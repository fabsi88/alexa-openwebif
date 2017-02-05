module intents.togglestandby;

import openwebif.api;

import ask.ask;

import texts;

///
final class IntentToggleStandby : BaseIntent
{
	private OpenWebifApi apiClient;

	///
	this(OpenWebifApi api)
	{
		apiClient = api;
	}

	///
	override AlexaResult onIntent(AlexaEvent, AlexaContext)
	{
		immutable res = apiClient.powerstate(0);

		AlexaResult result;
		result.response.card.title =  getText(TextId.StandbyCardTitle);
		result.response.card.content = getText(TextId.StandbyCardContent);
		result.response.outputSpeech.type = AlexaOutputSpeech.Type.SSML;
		result.response.outputSpeech.ssml = getText(TextId.StandbyFailedSSML);

		if(res.result && res.instandby)
			result.response.outputSpeech.ssml = getText(TextId.BoxStartedSSML);
		else if(res.result && !res.instandby)
			result.response.outputSpeech.ssml = getText(TextId.StandbySSML);

		return result;
	}
}