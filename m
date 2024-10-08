Return-Path: <linux-kernel+bounces-354677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1E9940D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D6C282447
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED2118C903;
	Tue,  8 Oct 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EjHjvpN0"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABA18C00D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372816; cv=none; b=R5hYeRJ1pO7ZS+EVVkPeh3noTNRmBBvzmdOJz5yJzR4vM4FMzrpXd9PxExmrj6SiLlTCxWQxqdl17k1c8MVMI7SMi6Js6o6bNOCHwgsMuPSXE34r0nEExtuDO7OIlBRTq73YEohbE1FDAEJDaxvtLCF5SSB0mFiidLtjDVr1tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372816; c=relaxed/simple;
	bh=ScNM5LpPQRFu4eVbfsRAPQTxRYHGbbaeFG+QpkZjGTc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oyi2yH3X2/4D+K7QC5I1D0mMXckiVJTKNxgfJu9V12lEAeUcs+vALFgL/OeiJmgZ2PI8R1cygc0l8HdhOWgTtRDwJaupE0t87qHvbD6y8PWuI9j2phtLGVGKvTluB/+sWjBDY0YM8n569jr844nMqzPCmCkECR3jrCRAVkmsoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EjHjvpN0; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728372787; x=1728977587; i=markus.elfring@web.de;
	bh=Cvlps11fBJRNfYHYhbNrt25m6N6b4aUU69m73IXRFms=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EjHjvpN0GLFQAjGi7MVF67u4+QmtUmpaSVRBo5CQt4aVej+DT3fus7R4AIM3KzV2
	 u8sF3hnrPjkJhORb1ypKvEmyZ0QR9txoaqnheWJkBr3VYx2A7JB8ye4H1O9y51z9o
	 kJjWHD3YUARo8NaOKJOZaDQSQZZMT7ZKidPrEuc0GvPxkUFFdRzEPOBvRZrGM4klM
	 O8Lhh5sOWBPJf8gxfnxkLRewTnXasqjneUUTh98upA/vlnQ8xbIhelbakz4QUKYP7
	 INoGDz2mG6wogLNwiOc9hPnJxu8tlheGqTP0wysacEyCNh4DVwiwi9YhRhGKO7hd6
	 Uft+IzT/ghLyhmeggA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcll-1tTcDQ0iqh-00X02U; Tue, 08
 Oct 2024 09:33:07 +0200
Message-ID: <0379b3a3-9ab0-4b08-adff-59fc8ff98844@web.de>
Date: Tue, 8 Oct 2024 09:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Adam Thiede <me@adamthiede.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Hsiao Chien Sung <shawn.sung@mediatek.com>,
 Nancy Lin <nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>
References: <20241008064716.14670-1-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v10 0/5] Fix degradation problem of alpha blending series
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241008064716.14670-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qj1iAxZU5UbJCMxFoe9Iz5waTfsYw2nGih47OSLK4wqrVTydawt
 vpiwPseNZPOF9JluNA6lc012WGZCE/8DY1NFX0YqKif2Qo9uBn2cTB9k5qZ0HjApF2KjoAU
 shINrmK++1xM42gaVfB4EqiNkTB/E315CB8KuUc9XdtI0IHKH0VIcuto3HHI+96uBGeCP0A
 Fi0gCv22K4sBfL7FMhlLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FTXtS/iD7gw=;KycOVj5RcErMRwfHtkm0NC6CG45
 3j3lk1oAf8tmJ3SwyUe86+3mZK8+wfc/tTrHJ+we7p5g0MQ3/La/2/CivdO4UKAQrQShavAVS
 lU2jLQcLcceLEfDmlkhxZdfmDG0SLmgJ5W4hJjj+TNoGDLJXk/hzvXPX6XjywkJ1scRX3kzUo
 y84cwrffKYPm2sOlkvIN139A2C7lhHK095MIXSZIfTatNezZCDGoMfAa4x4SA3TTomw9H+OtN
 Mn8BQuIc/ETtco2QAU4icZS0mQBaMFsv+QNHUjZuzNjYD4iWiW5ZISPr6ItTNQwoycypHW1z4
 qDkpBb9zLoWKeBPjzk3sy+P8JO+ThJabtLqNYg8nz959IzRcycmvFKc0yDWEoW7DxkeUVrR2L
 gC84/s6gZda0t8Y4uHSNR+VMT6LajldwdJ+zqXH4tZDBxHVW+9aFCsktlpDgORQALahD/IMmj
 FgxzeidCSjBlSOSFwHCN+6Abf65BCd6RVhXCmLnBog3U/4ErgonAUFVUwttKd8nRlacraD0Vn
 RIkIxxHfyoyqFyf80jeL7KsrFxulvU87udSejd2pyxnU1f1OZWzb9lVnATstCcGm/fvUqnjRP
 LrnkOUfUI98t00Ox4uevMV52aojsSOtWgcsmQYfs5hdHOxZ2Vtc3ejczq561q93nq+XnjuLPl
 es+T4eNZDr4TrgloP1rMpQ9NGmsTXSkJUN57nvseab5tBVbK2eP/CCw40oVcvQzGqLo2UcHWs
 lJfdxPyPztqtSyTnlBNgMMPbDFn1r69bw8jaqt8MuMfCalahHaElQCs/gc3XxfotVm+Hat9Ph
 N4JzNE49xITTTwxfs+sn29qA==

=E2=80=A6
> Fix the SoC degradation problem by this sreies.

                                          series?


Regards,
Markus

