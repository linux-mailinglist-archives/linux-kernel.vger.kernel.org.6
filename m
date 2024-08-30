Return-Path: <linux-kernel+bounces-308570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1CB965EED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE01F290D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FF19047A;
	Fri, 30 Aug 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mrwtBLfY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UXHG0aFJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SjF55k67";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="22obkMIM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B4190472;
	Fri, 30 Aug 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013178; cv=none; b=daAaPxFbZxgfYD7Nz7QPF8ggrsu+0eJxJON2vbzKS/dhHMqTq3nA2bcrTPY7R54pYN5GGaylwLZXwGEOfvWsmO4tknocJqWw1b8lIFWhG1eDzeRwAxTEf8KQppDC/1kHw6CraP4iB9XwVvvvSeJPjPft2gVP0l0MJLFCMD6Rnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013178; c=relaxed/simple;
	bh=wO7vMFPkdOLyYUsiY7riyYkjhqRZyhMzAxZ4k1osBek=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM7AEGkbmujYnhEQWU/8kw+q4o0EAaeNCTlxS0H5LozO4ro/9MQ9gwu1EM02chhm1uqQCC7XZ3OU+JJOmb5Us1CL+tX9npwBr//6YS2o9JFHmi3rPQl/yUnXr2p+OXgseW3YIy8xhqx2SLyjMBqW0fm0+ewFQwGK8uX4oJfVYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mrwtBLfY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UXHG0aFJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SjF55k67; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=22obkMIM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D86481F7BE;
	Fri, 30 Aug 2024 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725013174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPFOJa+kmQrE2qKcJe1c8BJADMfptk+py9Juhb/GWrE=;
	b=mrwtBLfYYLeSdUIWpnyeeJMVpb1MmeuNclPBbXi9/0Q1HoCZUv5IUE50PISAbwsWxjPKgB
	2wmVIyj1YX/wZX5zDabOV4SOJF6reFBzJ4jJm6f3VVXYc4xjKC2Cov2cZRt2Kjxb660Rrl
	vI+g/5ujTwiD90fxyt03buz9TdOan6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725013174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPFOJa+kmQrE2qKcJe1c8BJADMfptk+py9Juhb/GWrE=;
	b=UXHG0aFJuA8W1zWj52qxqWy4Mgu3r8g806PURgcSHyn6IP8Pm0W8HPw26x0cSlsXhXRYH3
	y2Muiq/81L0isSCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725013173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPFOJa+kmQrE2qKcJe1c8BJADMfptk+py9Juhb/GWrE=;
	b=SjF55k67/UBnyThixBMscd+ABto7/Rmwcd15Va6qLlG66pyQZg/s6vDCkpO9xbMQ5oa0uK
	05OpZXb1erKK8Axb8WKYYkK8BMSe4+LDjWi17FEZDfdbTiyAZfl/GCdq+jydD6cslwHOUW
	A1EgE7613u3mviZC0itAinMTuDFKwOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725013173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPFOJa+kmQrE2qKcJe1c8BJADMfptk+py9Juhb/GWrE=;
	b=22obkMIM9syGrZazHGxcQkNv7Mq8tO8xo22x1Ve+bPiO2ULp1sAxIF98sscMO2K3CnnRFj
	PTSPugrljzvGR0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DFF013A3D;
	Fri, 30 Aug 2024 10:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vt9VJbWc0WabGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 30 Aug 2024 10:19:33 +0000
Date: Fri, 30 Aug 2024 12:20:18 +0200
Message-ID: <878qwel3bx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Leo Tsai <antivirus621@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	leo.tsai@cmedia.com.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Add new CM9825 driver
In-Reply-To: <20240830084521.15706-1-antivirus621@gmail.com>
References: <20240830084521.15706-1-antivirus621@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Fri, 30 Aug 2024 10:45:21 +0200,
Leo Tsai wrote:
> 
> From: Leo Tsai <leo.tsai@cmedia.com.tw>
> 
> Add new CM9825 driver with standard and NCR model.
> 
> Signed-off-by: Leo Tsai <leo.tsai@cmedia.com.tw>

Thanks for the patch.

But first of all, the patch description is too short and lack of info
in comparison with the code change you've added.  If it were a simple
quirk, it's OK, but this isn't such a case.  Ideally speaking, the
code should be understandable enough without looking at the too much
details in the datasheet.

That is, please give more information in both the patch description
and the comment in the code.

And, if there is some external reference, put the information such as
the URL of the spec sheet.

Also, what is NCR model?
i guess it's a certain hardware vendor or such, but it has to be
clarified.  And, the patch should be better split to two patches, one
implementing the standard behavior and another NCR-specific quirk.


In anyway, go for the more details:

> +static char CM9825_Standard_Drv_Ver[15] = { "0.240723.0" };
> +static char CM9825_NCR_Drv_Ver[15] = { "1.240805.0" };
> +
> +module_param_string(CM9825_Standard_Drv_Ver, CM9825_Standard_Drv_Ver,
> +		    sizeof(CM9825_Standard_Drv_Ver), 0444);
> +module_param_string(CM9825_NCR_Drv_Ver, CM9825_NCR_Drv_Ver,
> +		    sizeof(CM9825_NCR_Drv_Ver), 0444);

Don't put such stuff.  Those are purely downstream info, and have
nothing to do with the upstream stuff.

>  struct cmi_spec {
>  	struct hda_gen_spec gen;
> +	const struct hda_verb *chip_D0_verbs;
> +	const struct hda_verb *chip_D3_verbs;
> +	const struct hda_verb *chip_playback_start_verbs;
> +	const struct hda_verb *chip_playback_stop_verbs;
> +	const struct hda_verb *chip_HP_Present_verbs;
> +	const struct hda_verb *chip_HP_Remove_verbs;

The variable, function and field names are usually in lower letters.

> +	struct hda_codec *codec;
> +	struct delayed_work unsol_hp_work;
> +	int quirk;
> +	unsigned int playback_started:1;
> +};
> +
> +static const struct hda_verb cm9825_NCR_TpCon_verbs[] = {

Ditto.

> +	{0x01, 0x720, 0xF0},
> +	{0x01, 0x721, 0x88},
> +	{0x01, 0x722, 0x43},
> +	{0x01, 0x723, 0x10},
> +	{0x34, 0x70C, 0x02},
> +	{0x36, 0x71E, 0x11},
(snip)

Please try to use AC_VERB_* for the parameters.
I see many of the verbs are undefined ones, i.e. vendor-specific, and
they can be better defined locally.  It makes much more
understandable, and it can help debugging.

For example, the verb 0x71e is AC_VERB_SET_CONFIG_DEFAULT_BYTES_2.
But you change only this.  Why?  The intention can be commented.

> +static const struct hda_verb cm9825_std_playback_start_verbs[] = {
> +	{}
> +};
> +
> +static const struct hda_verb cm9825_std_playback_stop_verbs[] = {
> +	{}
> +};

Those can be set NULL instead?

> +
> +/*
> + * CM9825 quirks table
> + */
> +enum {
> +	QUIRK_NONE,
> +	QUIRK_CM9825_STANDARD,
> +	QUIRK_CM9825_NCR,
> +};
> +
> +static const struct snd_pci_quirk cm9825_quirks[] = {
> +	SND_PCI_QUIRK(0x13F6, 0x9825, "Cmedia Standard", QUIRK_CM9825_STANDARD),
> +	{}
> +};

Do you really need this quirk entry?  Why not just taking the STANDARD
as default?

> +static hda_nid_t cmi_get_hp_pin(struct cmi_spec *spec)
> +{
> +	if (spec->gen.autocfg.hp_pins[0]) {
> +		codec_dbg(spec->codec, "hp_pin 0x%X\n",
> +			  spec->gen.autocfg.hp_pins[0]);
> +		return spec->gen.autocfg.hp_pins[0];
> +	}
> +	return 0;
> +}

Simply refer to spec->gen.autocfg.hp_pins[0] in the caller side
instead.  There is little merit of factoring out as a function.

> +static void cm9825_unsol_hp_delayed(struct work_struct *work)
> +{
> +	struct cmi_spec *spec =
> +	    container_of(to_delayed_work(work), struct cmi_spec, unsol_hp_work);
> +	struct hda_jack_tbl *jack;
> +	hda_nid_t hp_pin = cmi_get_hp_pin(spec);
> +	bool hp_jack_plugin = false;
> +	int err = 0;
> +
> +	hp_jack_plugin = snd_hda_jack_detect(spec->codec, hp_pin);
> +
> +	codec_dbg(spec->codec, "hp_jack_plugin %d, hp_pin 0x%X\n",
> +		  (int)hp_jack_plugin, hp_pin);
> +
> +	if (!hp_jack_plugin) {
> +		err = snd_hda_codec_write(spec->codec, 0x42, 0, 0x707, 0x40);

Again, try to use the AC_VERB_*.

> +static void CM9825_init_hook(struct hda_codec *codec)
> +{
> +	struct cmi_spec *spec = codec->spec;
> +
> +	codec_dbg(spec->codec, "Start\n");
> +
> +	snd_hda_sequence_write(codec, spec->chip_D0_verbs);
> +}

You don't have to make an extra function but just add the init verbs
via snd_hda_add_verbs() at the probe time.

> +static void cm9825_playback_pcm_hook(struct hda_pcm_stream *hinfo,
> +				     struct hda_codec *codec,
> +				     struct snd_pcm_substream *substream,
> +				     int action)
> +{
> +	struct cmi_spec *spec = codec->spec;
> +
> +	codec_dbg(codec, "start, action %d\n", action);
> +
> +	switch (action) {
> +	case HDA_GEN_PCM_ACT_PREPARE:
> +		spec->playback_started = 1;

This flag is never referred.  Can be dropped?

> +static int CM9825_init(struct hda_codec *codec)

Again, use lower letters.

> +#ifdef CONFIG_PM

This ifdef is no longer needed for the latest upstream code.

> +static int cm9825_suspend(struct hda_codec *codec)
> +{
> +	struct cmi_spec *spec = codec->spec;
> +
> +	codec_dbg(codec, "Start\n");

Better to be a more understandable debug print :)

> +static void cm9825_detect_quirk(struct hda_codec *codec)
> +{
> +	struct cmi_spec *spec = codec->spec;
> +
> +	switch (codec->core.subsystem_id) {
> +	case 0x104316E2:
> +		spec->quirk = QUIRK_CM9825_STANDARD;
> +		break;
> +	case 0x104388F0:
> +		spec->quirk = QUIRK_CM9825_NCR;
> +		break;
> +	default:
> +		spec->quirk = QUIRK_CM9825_STANDARD;
> +		break;
> +	}

Those can be simply put in the quirk table instead.
The codec SSID is also checked at the quirk table lookup.


> +static u32 get_amp_max_value(struct hda_codec *codec, hda_nid_t nid, int dir,
> +			     unsigned int ofs)
> +{
> +	u32 caps = query_amp_caps(codec, nid, dir);
> +	/* get num steps */
> +	caps = (caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
> +	if (ofs < caps)
> +		caps -= ofs;
> +	return caps;
> +}
> +
> +static inline int
> +update_amp_value(struct hda_codec *codec, hda_nid_t nid,
> +		 int ch, int dir, int idx, unsigned int ofs, unsigned int val)
> +{
> +	unsigned int maxval;
> +
> +	if (val > 0)
> +		val += ofs;
> +	/* ofs = 0: raw max value */
> +	maxval = get_amp_max_value(codec, nid, dir, 0);
> +	if (val > maxval)
> +		val = maxval;
> +	return snd_hda_codec_amp_update(codec, nid, ch, dir, idx,
> +					HDA_AMP_VOLMASK, val);
> +}
> +
> +static int cm9825_ncr_spk_vol_put(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	hda_nid_t nid = get_amp_nid(kcontrol);
> +	int chs = get_amp_channels(kcontrol);
> +	int dir = get_amp_direction(kcontrol);
> +	int idx = get_amp_index(kcontrol);
> +	unsigned int ofs = get_amp_offset(kcontrol);
> +	long *valp = ucontrol->value.integer.value;
> +	int change = 0;
> +
> +	codec_dbg(codec, "nid 0x%X, chs %d, dir %d, *valp %ld\n",
> +		  nid, chs, dir, *valp);
> +
> +	if (chs & 1) {
> +		change = update_amp_value(codec, nid, 0, dir, idx, ofs, *valp);
> +		update_amp_value(codec, 0x38, 0, dir, idx, ofs, *valp);

What this mirroring to the node 0x38 at all?  This has to be clarified.

> +static int patch_cm9825(struct hda_codec *codec)
> +{
> +	/* Detect codec quirk */
> +	quirk = snd_pci_quirk_lookup(codec->bus->pci, cm9825_quirks);
> +	if (quirk)
> +		spec->quirk = quirk->value;
> +	else
> +		spec->quirk = QUIRK_CM9825_STANDARD;
> +
> +	if (spec->quirk == QUIRK_CM9825_STANDARD)
> +		cm9825_detect_quirk(codec);
> +
> +	codec_dbg(spec->codec, "spec->quirk %d\n", spec->quirk);

So this quirk lookup is weird.  Just put all needed entries in the
quirk table and do a single lookup.

> +	codec->patch_ops = cmi_auto_patch_ops;
> +	codec->patch_ops.init = CM9825_init;
> +#ifdef CONFIG_PM

The ifdef is superfluous.

> +	if (spec->quirk == (int)QUIRK_CM9825_STANDARD) {
> +		INIT_DELAYED_WORK(&spec->unsol_hp_work,
> +				  cm9825_unsol_hp_delayed);

Better to initialize the work unconditionally.
Then you don't have to differentiate at suspend or free, and you can
call cancel_delayed_work_sync() no matter whether it's used or not.

> @@ -91,8 +729,8 @@ static int patch_cmi8888(struct hda_codec *codec)
>  	if (get_defcfg_device(snd_hda_codec_get_pincfg(codec, 0x10)) ==
>  	    AC_JACK_HP_OUT) {
>  		static const struct snd_kcontrol_new amp_kctl =
> -			HDA_CODEC_VOLUME("Headphone Amp Playback Volume",
> -					 0x10, 0, HDA_OUTPUT);
> +		    HDA_CODEC_VOLUME("Headphone Amp Playback Volume",
> +				     0x10, 0, HDA_OUTPUT);

This is a superfluous change?


thanks,

Takashi

