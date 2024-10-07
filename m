Return-Path: <linux-kernel+bounces-353658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774C9930D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A041F24576
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B601D3183;
	Mon,  7 Oct 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ckWnGuHt"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1C1D4159
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314004; cv=none; b=OKLoWp8Yx6eQu6fGngb0/4yQ6Cqk64fOLG8mKyimn8pP8o2thPN5JvLy+Y7z9YXZq870g9vxACosElxsW84SoDd8damhaXO0hn95rJr+MIq3TIQz2GYGZF7VCTzsFq/loC1D86xAZuWARAxvWM0QohdC3IAImFTM3W6EYNYQf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314004; c=relaxed/simple;
	bh=XNt8PiHSRhGOiAe8aOruShDn2RME9MmrXhLIkyUnMzM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DMs84JI2eZPNq39xxQknS9544nUsLl0hJCK6h5jGY7lVpFejD3/6lEH5YQaF05VuNoDfcNtweWCIfF7EtrF4+jIEVUDNPZupO8K5JN4EbD2MKx8LWZ0beh27bhyPUAKpSs6XL2olBHwS/7JUmckChtrBg/FjA+fyjmrwD9DwFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ckWnGuHt; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728313977; x=1728918777; i=markus.elfring@web.de;
	bh=XNt8PiHSRhGOiAe8aOruShDn2RME9MmrXhLIkyUnMzM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ckWnGuHtnv3IpM55KrFLYzxF29UAtZfhL8g71qavPkkAaJsEY5w1NvYdZ2C65ZiB
	 tKWUdwtRrhXp1kKzMw6jcT6BfFe9cuMTG+VGKApbHTd2qryzAcZZMrQknLy+h4ShG
	 BSELoTls79wocpEpqEofbIQncphwv8ZCTudh7bRMvsl/F89OEYLUQjaGM4ekS8u/U
	 sb996rvdPvcKcQm/QAoFN5mWP8Rrs5A3n5DNG18t6hA0EIwhwlmujN1/LrV1dFk+g
	 EWm5ws921nGiDvqrQXZnK5F6r/o7vMBTjhfN51eY1QuYtDJ41KkBLaPOUFCvemjao
	 qjGeQ1eySDD4aXtTbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxsD-1tK1EM2k2p-00ObJM; Mon, 07
 Oct 2024 17:12:57 +0200
Message-ID: <0fd2ab9e-66f7-44bc-915e-2a5c2d52d511@web.de>
Date: Mon, 7 Oct 2024 17:12:49 +0200
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
References: <20241007070101.23263-2-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v9 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241007070101.23263-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Ba8zBh6CcOHXB4RQMIGo0IzFQsQS+XJ52yqKm/QjZ/OaWqf4cn
 Civ4p1nJVkQGwGnIf7wGGzD70wZfDfvbyVxQTzmdjXlzu1fTfEWu8TegRsuYfdHVSwkgh0N
 u3vG1L3sqnf+vHHmazZKnCPEGLwiF1sQbm0Rwn5kWHrHs54fjyEOkQJOdOy4YDCGv+F5ErM
 yR0Zaf16vNRcHG1WjrnZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NoyAAvXeFxE=;3AyKjdVXmM17V36gSbpC/Mgn84i
 GaFke1AWEV/mZ22ie5au+YVcwE0CsgarP21NqsWWnV24gLj3ADcXt3tt3X38XbfG/idcZu3+u
 j1PLb3p4TeE4A44s54kjF4na/ANddJRaCTA5ly8GuLIoWPsm72hm6BpbC29AkeIOmpceh1gjr
 MFnWO3vEf0NBFw1XudvKOPr7UeyzaHC/3InlEhSt5o63UoorPwRgiXHHb0kwE2LG0bVf+u18A
 JNMPTR/vY4YvOCdRqhlhOZ5aj7YvK1FVY7fno1t1eEcEJvbYMgSBziFS3IZZX7aTZMQp607Pb
 aR0jH44EZ6gPBXrEtW1j5l7N+tPdO1R2rIB7jSB6SLR31cKy2pgy34u0Lq/40C7ruMaqDIwRQ
 qX0wg8X/jAO0qIBJi+6wTRAvlVIjDxphbBMSp1G0bfq+CisLpgOYZIjGqiWPHEy6yEiW0vzUY
 gllKsvkRGvTntQL2hBPvXfj8Vc+2Oj5m9Z9Ubn4m0IOvo1n0YjYNmLH1xeqrFwZI2oTC5LGak
 Cen/42hJXsnw+jFwc39swZt8H1IP9eDcgLsdzISq00BStOEQkPLfJP/M2oCeAsBhbGc3x+g2Y
 Fjb2TSdrg6GqWgqS4jLWWxop96ezkV0dYx81UcZGlPqzR/z1xyqWqWO8gIqd25EBHgtnfQINF
 qdRDqUYLFjH3TvA4IlM53ViihwlS0UBePv0IUVhRuJvET4TW9HgFOPqLnUNaVl4EMpl27oZOP
 2ZvNoKzqdZTA5+ZmNRrNqIZAmhD61Pf6qabCWuMgGsAl20rLpwiVZHHkzGUZd4Bs9kLzm1dPk
 5TG1bQSGyyqcy8mFGzvmwi2g==

=E2=80=A6
> Make the constatnt alpha only enable when having a vliad blend_mode or
=E2=80=A6

Another wording suggestion:
Enable the constant alpha channel only when having a valid blending mode?


=E2=80=A6
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Does a dot really belong to this personal name?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n396

Regards,
Markus

