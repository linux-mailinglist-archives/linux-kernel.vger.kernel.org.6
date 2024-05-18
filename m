Return-Path: <linux-kernel+bounces-182800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC218C9009
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA065B21585
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9210A39;
	Sat, 18 May 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iwhmvtrd"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE3D517;
	Sat, 18 May 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021846; cv=none; b=jGuMo0VPnJKVw6YaYHb1wSU45M31/Wq4WIsaQR4WDhjRVgNNJhWRR756eIRRnJOBr/cTI389QkPNpQwq1MwH6P++UhLCEwLKKWxK4q/z7qCpBoEJdt57qvT7D07pExjLi/1P+rTgEXxCkJJdXzj6eLACNwRLx2+OLB7m0pFGeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021846; c=relaxed/simple;
	bh=DGcKwpnm0IaxJEb1l+kKTe6wdeH678B7xPsroNWQ1Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV2EellTPlcafJocJqpeuRSNVweGyIrJejipp2H2leHRDJJSMAHjH7MedsUVPnwSluea6t4E/vMh01lHbcJf6PeLgD7u2lQumZxGev3nmS2F7lT1uRd0WFVvyz6rcszNGPdb5E7MgrMFNF0JNd4JiKH0Yxyd41w+WGTuCxdfZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iwhmvtrd; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8FWTs7QkmyBie8FWTsPyIk; Sat, 18 May 2024 10:34:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716021277;
	bh=HvBJuxK1qEQGY419eTHQS0e80FA2YaU9Iq9DBa3kX10=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iwhmvtrdL4BdsBWGJzKEpidQIiq9tYMuH0xt9xdOS7fc8Nl1J5yik1eSFqgb2VZgk
	 SfKIbYIHE0a5ct0ikO52QWFqvqm67pgrZcUKpOhlNNaZSwjY+YKVWoJS9xAbRgwpso
	 b2oBsgypqrjRFSFwu6ix9ZOftKcBVWYFM86CViQ6avj4S1KqDH0LPBBZqFNCuoA+s+
	 BTV4OFbYmIeHwMF2gZU4G1w91Scp5bZHDLlI3pq7cApCALEzGcFQe2JqFcb11PClPJ
	 syUymcbQu6mylvYyG3smWFis+IAGtjZ6YoDg+cbrYl18wBMHJ4ThylD4w8Jm84nPZr
	 tCstCJWA+cZzw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 May 2024 10:34:37 +0200
X-ME-IP: 86.243.17.157
Message-ID: <b736e11e-430a-462b-898a-d5e1dcf7f74a@wanadoo.fr>
Date: Sat, 18 May 2024 10:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ASoC: topology: Constify an argument of
 snd_soc_tplg_component_load()
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, daniel.baluta@nxp.com,
 linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
 <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/05/2024 à 12:21, Mark Brown a écrit :
> On Mon, May 13, 2024 at 07:37:20PM +0200, Christophe JAILLET wrote:
>> snd_soc_tplg_component_load() does not modify its "*ops" argument. It
>> only read some values and stores it in "soc_tplg.ops".
> 
> As mentioned in submitting-patches.rst when submitting a patch series
> you should supply a cover letter for that patch series which describes
> the overall content of the series.  This helps people understand what
> they are looking at and how things fit together.

Ok.
I usually do, but I thought that the subjects were self-explanatory 
enough in this case.

Do you want me to resend?

CJ

