Return-Path: <linux-kernel+bounces-190309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D278F8CFCB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932FC1F233DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882E13A3E6;
	Mon, 27 May 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hTkj12tC"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F1139CFC;
	Mon, 27 May 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801773; cv=none; b=TSrkTbWFM27M5hpbRr/Hg8KIFUm77wnGigWIMGeg8utmH6iN+LbWncVsF3ETCvVj84NvHGO1IZQHl/x80u7VJLqFJlObEg1P660ZtO6RRjm8Xihuj31fjOOOscMEcR3rPQq72pOmwdcbWiWqhgEHde9E4rPIOA5TsjP61e7mx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801773; c=relaxed/simple;
	bh=sPpYKX6e2tu3TT0zTxK282y8SKfHEdgc9wUY0M5CiN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpyQo8WR95S0Hn25A+7+a0NiuE4wbveHzzlOWH7pv9L5d6Hw3Up4g1TSmbVu0g/mlQSJ2qQ6uVcB6IYtN1NBE5HC5u5vSlDSQ4qDojaqHo6/o4weTPB20eMXDOjaoK0AfndpXbUor8HwZUU9eGUzp+SoZPUf3sNOlmo5/gFDV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hTkj12tC; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716801756; x=1717406556; i=markus.elfring@web.de;
	bh=Rb/B2ovHnZ6QCVFezt1gZmqIJ3Eo3AhrdizD4T2BxdQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hTkj12tCBX3HI66imhYWRFCG4rSHyzcmExs38b+aGk/TttJG7wwTvamyTok0aLL1
	 kbbYkfhrl+OvHU9NpXmt6g5n7AjApV94E6I/kfg7P1VcRKaRyMHxrq/Uame3tRq10
	 TdgdwgRSoAxaYEMtFSbKn8USNelXdplk62x/00LrOh3+69MdE3BN+KHLjI2Q2V6l9
	 QU9/wFhsT8t4vs+tmpe/DvRE78rpJGwXdul63tmfztUzxlGuMAqhgk2eEIEUbNaQ0
	 Gbt+yJFBHHFI8kgfsu+328q4FNkMySomc9z4zERR8u3h4finQn4VzEw6xKWEBE2hV
	 i6cp5kbRtGEWX8uG8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1sCLuR0mkV-000qYL; Mon, 27
 May 2024 11:22:36 +0200
Message-ID: <e6762978-d35f-4356-beac-bcb8b36d3ee2@web.de>
Date: Mon, 27 May 2024 11:22:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/loongson: Introduce component framework
 support
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240526195826.109008-1-sui.jingfeng@linux.dev>
 <20240526195826.109008-3-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240526195826.109008-3-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xat59LEQihQ6e/FrLPV3GI+wzB7H+wFr4geqZy205A9JyyREx0J
 cjeWo3zCyOMWbeJiSfuU3OLNPTAnTaC4MEkK6agdN/2aQbVPPmmD2/ActAPjc0pF9PKvuSl
 2UuAeM0yYBXQXWR32hpFx01ThUFbP9/tXtaVzRkttjgc/ufNoB+dpVszVpeNobklc9fVb3a
 Bqxkc5Ff836eLeysjExsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A3PTnOl92B4=;nAi17OmfVJQD5ZwFF3RBuJzcxff
 T6p4Rls6Tp+X/czicoT0qucygzSBqbDHmhMrpd1XdpVpLgHsEe1EuK8lsEig2xSygyFg9qTxV
 U4Hnb7gntzPZ5SKF8F04ruBjvOgoEuSzcaDdia7WPh5zZt7C9ZivRrcgArBVa7untyLvUsS+L
 FXBEtr+zGGek9pnlxwNv87qKZW+bNpkoCHhhJ/3sdFhbQ9TOlCD29aw48JoNDZFPrJAhikLWk
 ahcaHiE0HeIXXmMoYOrSW0EEdBhUM36VM2pJzW0EPm1Ghehqqf1zj+u1/QjuapU5LV+uVoWSb
 TiQYvE6uTPtI4ALpeMw5paHjwTwIdBPcvQ+lgRrEKpVvjnpHK3k7pTK30e1Rh3tnnZ7HKiiTD
 Tlyg3WfFaQPJTtkQR0ZWdrU7psPSveQeH+M2EzHdCoQJ9m5P2uCWaJnfJ4O8e84eAWO6H1+G/
 1HHaFt3wRZI5YoEC7n2h8xJFqSIJXKnLtxUxVKIkP3guCRBPjTStdXDwanqixyL68yXc5n5L8
 UqK2rdsB4xiFlCVYVbeoDpXEp1a/UxUgFRD9YDiriX1/p8ViRrU1T4tjMCt1iVoYJ+pyd4iiL
 4VyvYwd23V1BXRrajdnGcV457xTrTUNsLXqNB8+szP2iXuKa7tIuDqemToVoQYYuny4wZrOkf
 cKgcEjUr7coCkEHtpA0oXuhfmDRdCgXfWmFPIKElx2E0pOWQ0xBbrz3zvBY+4mqu3z9fW/euM
 TwAWDpsWRbOUot4+WGTWkIE3T9Fd3LTOkYUAKb2x85Ks7KovJdjEOT3GQFN7u7LuPQ96TlFT8
 qMJs2PqxRAZVqKbibpS2hzmuS3TZIzsrd/McQV+YO+xAc=

=E2=80=A6
> However, the driver needs all of the subcompoments ready to use before

                                       subcomponents?


=E2=80=A6
> goes with the PCIe master, sinch they has no dependency on exterinal

                             since they have no dependencies on external?


> modules.
>
> While the outputs drivers, such as encoders and conectors, may has some

            output?                               connectors, might have?


=E2=80=A6
> if it need to do so, the master drvier won't bind until all submodules
=E2=80=A6


Please improve your change descriptions considerably.

Regards,
Markus

