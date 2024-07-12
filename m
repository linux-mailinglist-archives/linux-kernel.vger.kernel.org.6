Return-Path: <linux-kernel+bounces-251082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD2930065
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113F11F23B83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD61BC59;
	Fri, 12 Jul 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sBhmwunQ"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE08182C3;
	Fri, 12 Jul 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808173; cv=none; b=pLBUJc/8r0KataBKqy66zgg90LMmjCAgEaJKznTHG+c6neUP3pBbrxRuEhW9YMNNO7YFqW+cNCshqKHhDlDOSOEkLf5LYsjf2lEmFssbTH0AtNoGrtpqdTbFCltoCko8rkit4vzxbGSc99mkzVkodPStoITFiNhVVoV88KhktsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808173; c=relaxed/simple;
	bh=t8snUp8OlpFu84YVregM/JCFkWMWslnOdGZMoDXezMA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=telkF/hHJXsXBXWWIca5KkOKnyXMBCEhKVMDt/IIV0PrceTd4G4a19wutrwFfINFH7U2nFddWz4Lv/HBuCCUHRvM+wAv8lD222xZQ5EPh+HTqFTFgnw+2VpZzKWVxUyBbSx32bSLGvgxFbtjdICX37t6unk+4OBYgQ8+vyNd0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sBhmwunQ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720808139; x=1721412939; i=markus.elfring@web.de;
	bh=t8snUp8OlpFu84YVregM/JCFkWMWslnOdGZMoDXezMA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sBhmwunQYOeOrhcHiiqMEEhfttL86bQ6UpIJ7eurXNKlxyEXUHj72ldM7RkJK1/C
	 HSvcDboK/o8S34W3v+z3vwAceoWMgW4xD2CKlZePx+F4kOGPNHK/T+PL8F2/2aZVX
	 Paaa0DA6Yzet+1vGesTjcvmNfzElXDMZMoPVeHgkry5D5uRZzKhpao6rGM5h9BNAm
	 I5NzoerbMTF3RaCzTo1XULvGUXtc1T5lmS+Mq0sptl0eZNNQoIYzQXtBTD5pnmlcY
	 Itr2zHuXNGDUnyt+qmajJJz7pnu2wQ+LdkjLnF7lWZPnu04c+jbydEr9W6F3/mtx/
	 UFxX5juKkLcYvBPx7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1rsRYi1UkB-00gF3g; Fri, 12
 Jul 2024 20:15:39 +0200
Message-ID: <10a70b9a-4ae5-4293-9fee-317b46390179@web.de>
Date: Fri, 12 Jul 2024 20:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pankaj Gupta <pankaj.gupta@nxp.com>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
Subject: Re: [PATCH v5 0/5] Changes in v5:
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RnONSGcbcr2GQOx/W/vt/PcQTj0CXwIS349iWWj5F/2VEFs7rgf
 1wyaCcRS7m/gvK1PsNgspSi/TI7yFkPR0jKr/hAWhuX2CQxfWuP9Bl+qwVuTSl2BoSrGiYE
 XXxe5TygU/1NcgBIH1twGqP7yngMnjaJWoL7yOmBR3uah5jtqHMsh1fcnuZScBGmxj8Xt3M
 ouJUI1xNTK8AGskf2Ge1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J+whdxPLS+w=;1+u74jRR5R8v8owJqhj4Udbaom0
 gn0WvXhiefGxk7qvXxJmgcorpzUD1SLyNDTYQfAYadbmKDTB5dvm/jqaiC0nQVz3X/QKm1oAN
 Swbtydo8YfFPHce0W76VpqbJM78L0CTtw9sKZwmxBq4W7Nz+lIUjp+C9drnmh87Qqzl2r11lV
 0uRx0MsP+QvNG0st9Q5dYL5T4hGVoythYs+VTSJ2PnWs26KxG0hYVS021gL0vRaM6dPrhVSM1
 SjIkTbWzDZbRXat8LAvEc8n/vQ2TXXUqLjNqiwr4uA8uIy4Oxa7jdhMZt4jAFujwU1Mu6kEAa
 EIGp+daHUoH8S121f9dR0e/lBaEqIJ5+xEikiYldyXzhokdLtbpSWz8ctt4DioNN8Me0i8UGP
 mMM2E+938CHFba6EHEZVl4W2gcwWMIZsyxX+UAowfhtA3hfEAsyHw8dsZ+bc8gcX+NsXDNS+3
 QSx1t4IonG23OZbMpb5Gcf6WKKFAvP0Wt6kVt2wCqGq9Hizq79Ir7LG3FI5Ge9rrgNn3m92El
 6diMjONEMuHqLEFAZHAiBPTPd5PxbehAS1s199q8w++wdLHr7IJQw/coHpxuugm7kpH76QeCT
 KKDqZOikl+O3oV/drKBEopwE6svqv04KPhZKJkH7h2jLgU8MFjxqi13Mb6F5DYreKyjP4c38o
 i1HtgnvmnDBgjYEuHF7mWHqQSl1rK/Ppm+W3Od9+npPkml9OGOfaDyAhWNBpJ/PyhBt5VrGpb
 STPkO0MsBuaCkFYriSwXPy7FbHlS2hF9D0gmhB8y6ah/BKGCcm+YgcwjL/OQijx/RwLCas3k5
 rcP9xgywgNqZR8Nl8fDC6m6g==

Please choose more appropriate subjects (also for subsequent cover letter variations).

Regards,
Markus

