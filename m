Return-Path: <linux-kernel+bounces-556701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A3A5CDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D293D167404
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D2262D20;
	Tue, 11 Mar 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UQTP0+QG"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466D1DE3CE;
	Tue, 11 Mar 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717057; cv=none; b=KQnreFZ05KKi0v7rA6zNJvmtaccZcijL6vgVRwxAWqSPRLKztKfvpdNSk8HOHi1s1p9nuMDat5HjlcAyEj2QxTkA54C+OEhrZ/fLVsWtXNskimqASGq7BqbS1hWFY5UUVSZSX1MrAmn6vTyot5CGwehsI834BA73HorKo8LjGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717057; c=relaxed/simple;
	bh=dqGSDt393wLZ/84AHq84a5GjTYPy0MUv/hZxhrhFPKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uX0WLzeZANQO5HzLR/Kf6u8H5LDUXNXeQR+VrJ/rxFZk9LnbnPcBrA16r82V3bdyt0DVi3pF7MBysKQRgggGHBHoS3u1sQqhcepRHUBnd8sGQnJhC4bGK31rnRQACEpFECmrVGRCoIglkxRkHKgE/7+Bdce+sHz+ip9qOZmIawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UQTP0+QG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741717032; x=1742321832; i=w_armin@gmx.de;
	bh=dqGSDt393wLZ/84AHq84a5GjTYPy0MUv/hZxhrhFPKg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UQTP0+QGJiNXurxJI6ewZ76EzV5MVgOTTd+FYVBzzKpN/UnjwozbXwpSx31He3Fz
	 wW9JPaEymJFsTDbabv+71MgwMLnLocglmyh19yd08m+4ZfkAu0483l/gJA5Ytwthp
	 hLTgr0O8uaXYsWBAijJ4UnCTRoLcJO8YJ+0cMqJqkUH684vq+Oz3W0ilJE6sC2w4I
	 j8OhDc4LxyyC/AxmGu19vSERZcam0Ark4GnPb/02UINZObJ5SARfhZYrOqlwQ+8sZ
	 gL/SnY7rvKaa1L6wLQzhFoOYfrZuM/o3A23QQMy5Z7lHJj5ezD9KhbHQKu+G8BOoh
	 Kle+Jc/F+FA0wYjSOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1tqO8o1Das-0001Xq; Tue, 11
 Mar 2025 19:17:12 +0100
Message-ID: <de49b8e8-e865-445d-881f-d26a7bbcf9e0@gmx.de>
Date: Tue, 11 Mar 2025 19:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hwmon: (dell-smm) Increment the number of fans
To: Guenter Roeck <linux@roeck-us.net>, Kurt Borja <kuurtb@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>
References: <20250304055249.51940-2-kuurtb@gmail.com>
 <bfb70a81-2ac1-428c-a327-d5098a8d3ce8@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <bfb70a81-2ac1-428c-a327-d5098a8d3ce8@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uXcIDipZnToVJPwtmi/zIJQTB+M2OnOSCjaA0R/DWAQbszG0FWt
 qDiKkeZWB0guqKpdOIaqHUTM4U6IhIVtvNW1+Y+kTvJCXp72XTQ/H/F3WNzhy946gqPdbm+
 eMXWWhpQKVuwB4l5KZm6698QEG5kiDVo+PaVBmudg+dXW7yrD233uWTE6OBB8k4tx6+iHnY
 Z3NvavRiKRM5gDCxWbxjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3jH106I87AI=;6bQ9AFJbPDG/5Gz/9aWpUjpttvP
 vj/QwmAlte2tJXxnYIfPIZCtPPYc0l/JkOE9DBifo32YIvQhlupZp5C0O5uTyySvt+aAwcsgb
 /cqSfhDiZU0H94TkbcTUs6Ho2Qz0DKUk1g4PAXXeEe4XyX5DhLbGsjARB8ULHgB0mDgakeBEg
 YqDh7NAIsjjq+Ztr5UJMv4QEfUROJYTByCbdpupMgcWNRrw8MzbUHmMNJiuewiJ2e4djvpD2v
 3zscZA5VDZsTuOErDicREoFPwjQ8SJHEBY0XVUOu1n/cMMGfmYAHsj+ht6ef9L522XMoJD5U8
 G6Xx52QlHwnfOqjjpnSRxhr4Zt0UAYKII8bbQuTZ8ENSg6Oi3VOSMzfcWeOttubfy3bIH9AMf
 pwIkzcpLYVs5fknE5haDVd2tDH2uHHO7TfkYXif7Zmvah9YFHPKM/mU5BCm+fv1A97Hb4cVkR
 hED+p8PesDjexN43OCljmkH01Nt7h4mBdbhNwgaADL10AJflhHxW5dK/TyYSxF9jLH2Wq0Saz
 wVj5qcJsLUbKn5OfdA9XPr1g1C/DvyBbbrh7gCH5EYeKySw/J1sNlx6pNMnzdgznVuRzB9qZS
 7bzZkpISsz0yEhdR/ByirT/f7rusYXh783/jkMqMQQsiTMbaYPuFe0QPaYUjgzRze+eSHqyV9
 pC8cukM4+llCiOTK6s15LQ0Psim7XmFsHOsFNVKi7SIXDW6qN9a8ssp3YPVoOBH63Hrcd5T/k
 43ay5+XuF1VnYnm1zgMofx0OPs6ZKpQsDi1npIp39bRusOr/JriRNucAtUbzUWETKpcFvbH5K
 cgdrKFZC55jImxa1YT3hhId5pTcLqJvJ2yu6F1KhZh7GcIxNlc3dMKN9GZXhZZstbeMyP4Kl+
 B47SQNzIDoCMsFGSO8LaG4KQ/sH/y3N7ohXidBIIR+DtBSWVPZOcxPhYGbCqIQNKWYm3E24Nq
 NSYfbiqsRtmvpIlMzSYtPqxjSDWRMoqmF07g6bPncQDWUKzMUcu95BJssdQDMF9cdZpftEVoD
 oHB9Pvx8u9nV3SWL1IvYtvkfLVtwFWIR17f95trG+V5hU7OtZJYCrZtqadMuaGZW2L6k67sgV
 GZ4DAHQKBaZl731v1cFH40jHn9lbr+Xl+ztkhNF4U8/HB2TyQ1MXo5ZpN7zjpSIW3X287AnIc
 ib7PFV1pJ+mUETOr8NhXryzP9VxCtyK0h2WZyzWs422BUip36WFEUykBQWCpZrFRchlMCPfF2
 FLn3HnaaeNE0nN6iB+hB+KCiHLlD7YQR5TeSXvH2S/DCp2VyHjGNxR9ZadKOhnX24Bsi3DIo+
 F50KFvziYIemC9m76VFA7hvj2GPq6fHf0CwFSlXqNcSPmh7xhX4klvSTkS7wrEsMUdqEPNbEO
 Wu8R/B+jUZ/0u/VUeE/FwbDffBK7iAR5cw6N6syNiUnWRYARZB9R3x0IIy

Am 11.03.25 um 15:13 schrieb Guenter Roeck:

> On Tue, Mar 04, 2025 at 12:52:50AM -0500, Kurt Borja wrote:
>> Some Alienware laptops that support the SMM interface, may have up to 4
>> fans.
>>
>> Tested on an Alienware x15 r1.
>>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Oh, never mind, I'll apply this patch. If it causes trouble on older machines,
> we may have to make it conditional, but that is not a reason to hold it up.
>
> Guenter
>
Hi,

seems that i forgot about this patch, sorry. I just tested it on my Inspiron 3505 (single fan)
and everything works as expected.

Thanks,
Armin Wolf


