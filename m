Return-Path: <linux-kernel+bounces-220336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3090DFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E74282021
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641801849D8;
	Tue, 18 Jun 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hgQ/YSY/"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7316FF28;
	Tue, 18 Jun 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753359; cv=none; b=YUycmZO9MwGvcroF86VggWDzmk/awTfhx+TucpptN7xJRahdI+rPZZhZyKoZm2sIPeiFBt5musfr9hquc+QeXBuv/VL+qXbpArHKF380ib8HD/iKqAKxTUv4GxQrRYL81vi01yhpmkYCTTzfKYikMPCQ1Zesr7Ctcd/Qu/d+8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753359; c=relaxed/simple;
	bh=WOQWARhUZWSfqQvDlg3ncf6oaVVEQYvGzmOoJx/nlDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iRVbWdINRBcycb/Q3B+EviuDHUCmwHpS27PxICIcq+jgVjQHsZqqE3Ax5fGCZHvp6usBbbExLnlDZjx0Slgr4zjhiPuPKGP6RDwfFH/kZ/FKEP+tlAeqEAqVNwWeiiyBDzt9RrLI7xIpeNVbQiP3Rg1DSnqqOhAgMUOriU0FHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hgQ/YSY/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718753319; x=1719358119; i=w_armin@gmx.de;
	bh=WOQWARhUZWSfqQvDlg3ncf6oaVVEQYvGzmOoJx/nlDI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hgQ/YSY/LhXNAClFUG7qy9LhAs2FaJSQPBT9sBrCtwhHUZ7ZWkVpPrvaDs15MmH2
	 fZkuYcODzxZIDQkydWpTAAMb277wsjNuA9GmvQw43MgBYkfKuG466t/8k8D0CiKn8
	 LlWVSgXfiNaLpxqZt2Sp1fkb3BNKcYi7xNyKdIj+wsUZ7SMzGSHa4qgloPsM2eN+K
	 Z3nVomuQqlDrA6JcWRcVJsXhjh/KAKERDOCsATFpdU9sIth+TQHFP2Dp8gopPRI/n
	 brMbmZNViZdwYlvfIKFzGQYl3fuLAyUXw38BzhCwYRL1KYe9aAqS4Sx6CqczsrfEo
	 e9q+9XjKYzIFmR0arQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1skHd11j3w-00gUUi; Wed, 19
 Jun 2024 01:28:39 +0200
Message-ID: <4755d088-7eab-47ca-923c-db1fdf3611ab@gmx.de>
Date: Wed, 19 Jun 2024 01:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Guenter Roeck <linux@roeck-us.net>, Paul Menzel <pmenzel@molgen.mpg.de>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Stephen Horvath <s.horvath@outlook.com.au>,
 Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>,
 Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
 <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
 <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
 <omsjeb6zbkcdhh4a3urjdrdeyj2kczb734tbhxwdcvngzlm7pe@dzdphvmm6asq>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <omsjeb6zbkcdhh4a3urjdrdeyj2kczb734tbhxwdcvngzlm7pe@dzdphvmm6asq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0d/yd16RBDh049RhGmMfdRqpa/84bjtrfH5mXCL9cwRLtotDwrI
 DXJ7dSzsMuDrD2Vynw8GTwYdXPrWHiPYbIKx4HX9A8p6o9W3QGDGLzA1Yul4OkK8pP/KOY1
 LRuV2JlJE8q2XzyMMz9nuu6wpiK9/cRm8yn7wFOttkvgFxvgGxQxYbz+3MCVJrGwkK/Nxl/
 VGWA2L43AGJgH8p0+mhbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DwVp0R8OMCQ=;nTohlvIX4WCZcsQ+o04BanY0Tsz
 hldDmwO+KU3/AjjEeog74YFcEzAT/A5BEoJDNlSgAApM/bPxulsBHCchPekMVABuBt5sPJy7m
 /K3ShR7wLMpImGA25natabG6z7PLC7cTBwuN4bkNw3mx29rlLXuLiqFcW9wy9r6uKn62Xq3qp
 PAk48PnpYR+qX8hlY3WKBtPTIprVKGJwcXmSEuy1S1pKBkY5utY7g9nBzX74OA992PrBnVCxq
 gvUT2vliQr/vVPqYekeoBCrn1eLdFd4d1UVsY3LVJ/vrs/t1SI4q6d3ME1Qm/9A8XooCcNpN0
 +vOyox1QUp+0sK0h8j7dZb4j0Kqox1dQXZROW6gE05FHE11Wwsw2LGliBs4Uj53w96mizrGUc
 JE0qWAmMAmi2Z0iEfZIa1Ev9K9IhOGyvy6xyrEkc+VFgrlRVwgyvB/2ouyUJj5/CFY41vknMJ
 yjgEvcHQ9CNMhBGmPYr18YxC3EUQEuTIt0lWSuTI5MpzpKuZjqym3Laf6ahMXw6fmSlgViMNO
 kJa/xvibBo+MSOYgf1HEhH9ycTJgEnVSXCbrURj1cme3rT/PCi9Q9PSwHV0LanyEowHJ+4ZSv
 Pt75BQEEQg3PiyhmL7pxs9Q0oq+dIPi4htmPsdgGx5k84K0WKWVow5qY/zZpPn/gelZHzx3r+
 mnvbXDvAuaYRCTTssOHzToWQogJsUhi+DUEnBg4IHiGwzGL6lCxAM7EbdOD8hJMKPzNqaKKoV
 977QU9J3UWoNkNQQ1wneN79MylIxWHXuWdtXq+yK2rmWE0h2lZGL8SHRUN2Vfm/maphw4AFsz
 JsptXPPtEUm9MLDaAHfBSar+fbr2sVSNdu6JB+Am/BNVA=

Am 19.06.24 um 00:28 schrieb Wolfram Sang:

>> to 86 degrees C. If that doesn't work, we'll be really out of luck
>> with that controller (or at least I don't have an idea what else to try).
> Try CCing Heiner Kallweit for ideas about the i801 controller.
>
Hi,

i am not Heiner Kallweit, but i found something interesting in
commit ba9ad2af7019 ("i2c: i801: Fix I2C Block Read on 8-Series/C220 and later").

Basically, it seems that the i802 i2c controller indeed features a SPD write disable bit
which blocks all writes for slave addresses 0x50-0x57.

Does the i801 i2c controller driver print something like "SPD Write Disable is set" during
boot?

Thanks,
Armin Wolf


