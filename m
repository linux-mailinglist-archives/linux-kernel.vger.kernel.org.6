Return-Path: <linux-kernel+bounces-546376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D08A4F9CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD213ABEFA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE7204C27;
	Wed,  5 Mar 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cMUx7bA1"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498262040B7;
	Wed,  5 Mar 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166495; cv=none; b=oYIFsLVfjBHLJm8KeDYQNk2K0e0ukuHpdrQS+tiafs/DylkUmra+f8prL5w2e/0o4MlteMzisvJP9xCnXTsRj/oxB47JMhOHT1B5X3auJPLEf+mdpp6Q52ug39xSqegFf2iE1pnMbNKMfymEjI1WJuDztgcnM0UHCLwDsmk+y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166495; c=relaxed/simple;
	bh=24L0NED3DjrdA3GApGnbDzpGeLHrvcfd0hoJ8hWeYK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otpttMSIW8mAyjm1CWm6SWTPMwzDBK1DwUsN2EYS8CT77VHnzru64N/LmVUC/RZGviT3jk3ya+sXoD/5O1RYMK73GGIRT2perMeMCuYMKgSXceef3f06KuwV+lZm4oslK+YwK1VLk9VkE+vpA2FRsxnHYLUviS5SiyNqGqp2TdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cMUx7bA1; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741166452; x=1741771252; i=markus.elfring@web.de;
	bh=h7MF2pukzcCQNx/zWpZiCS3hgViBAj+HXBu+xCaW0ac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cMUx7bA1rSuadObqsP5/9GPP77G0F95Jptm825dUCW0m387ivjweN2joWqlMXaI+
	 IcBA7fuTgGI0FF01eQqUH8fECJ9YtmF2yf9wWYvc24jJeXCH2KbsuBO4jpZK3FtVh
	 NmyDRIc/+dORmuANznZSyZK8yX78IqwUgid3oSoNWoOzDUxpn68i2Ifd53uRZQkXp
	 3X/nLV15MA00SxregkO7FtgxdOD8g1sHWgGzGnax07K/UJxrEXMnNNSFA2G9WtdCa
	 2kpTtojfihhjt5kYreeSuJsvLBlvL2ziOR91h4uTsDhNq/ojzAIo0oqVyeGGrm0Tq
	 2gwmSMJmm38DLSiFMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1tr7qL1mQ1-000RCH; Wed, 05
 Mar 2025 10:20:52 +0100
Message-ID: <a6243882-e289-4a08-9119-3c73933d6458@web.de>
Date: Wed, 5 Mar 2025 10:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_Clarification_for_=E2=80=9Cundefined_beha?=
 =?UTF-8?B?dmlvdXLigJ0/?=
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
 <e665514b-5a62-4afb-b267-7c320e4872af@web.de>
 <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPRCchf5c9fDV82ZnVt3zyworm0/jc6du/DkLT7OlMhlEOw06gL
 14PuC/lWkV/JePSRYwvu623J4IKThp5oaGF4ynFVpdhJXlVZxPSJjnmuEmhahu+d2ScWbqm
 o8a3oV/4fBh9DAyhBQ3CB5ZRuZZKROAleHVK2qANvWYGsHI0540nBiweJw10osUjOHUwX7V
 R0TgSdK86F/K8S5BWqmdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HnHMVUu0qf8=;HtW5MydlmAVPgeX+uSbHvOiYseX
 dM0hYYg+7B7fGA9abFJssSljkkmmEfoM3sCZ57ejyN7SkfRkB/eHpf5YwPwnybrimceAO3nol
 tyhUZepOSoQFqbR0W+vyRfnLUhiu/Bfla7goEUf1YSK/DxSRE8F03d56EH68VDTWRtN0AX09E
 l4sdclwQTcxe6pMuVRcS7I6dXcgLzZUqTaqD4WN3wZUlFUteqY3xGT6+iDobs9GFDpcMYW6iD
 aC7TOD8jjJXgViB212eXZgyV0q9LQcV4JB7lpQBeuCIyXdMRqdG7RTXLDr7l36nOn8vFveT8o
 4pF11vYIbpsCPh2/VCUo6JgduPAuB/ZJI50lFc34gTQvxD7SsjHlcPSzAKSWmUVYcnvhia+2d
 YaXhvf/7bTuF3pTNoOWFzKx8yXdJl2Kza6a3kdzA2YTa3iwz8ONBvrIFdLhk7BHlF2ouT04Ff
 OmxyMXmIyAbWbst3L9v5xZz4dhndC4p+ytsiiqAl47057acFB7GDxNKPeKXS2p0wThhNTtfWO
 IbRQpLRTby8ogQrtbzbGNScxofF0CfJsu5mWl84xMVn5jdEgTLd0iYtIt3Lag92yw/7IYR/vI
 w9SKBfGKiFhLdzdT6L7QYvbVRpMwm6Z08zdbov1TYWsA/pm87SG50mRoN5+gma+R8zxHrjFQX
 2uLxXKhOPsTbsSaDxNKrgY7p0w0txZVc8eeFchvb/1x4+1zOpm2iJ4JlZrxHpPZj3lu9yBvk3
 MmnqlL79molwdVDEzXKjotOq2tMGmcpdLbg4zsN1FSm71YNAzUS0ipSBZlcUuz1JhLH0m7wfw
 8nJnYjLY9QthG5v+pdbFCSGkn0tPY8+gDPZyj/o1iSB2812Bj6A/il38tFJqqQ0GRHZImDWJv
 hI9lNCLnosx4+ii36ET2MfDgeLR29z4hrQiK5cUDr58us3kmj1AmFJVSzd1VgzwHo9woONiSC
 n3RFz8L6e1GLU4fOL6y1TKWsI6ICKZgQDXMqsr/b+/OWgVZ+3FbJ3AtRZMsN5+iFqiIJPuufp
 jKFUCMJObBE/lYvqfcIJPviwZ84qFJT1coeF5jDRMUWOHnwaNnjCNet4W6U4GIOsXEmM8VRi7
 Y9l8ZVPemT88XSrKUw5hcgzAk5rYc5GD2Bf/0BxjAd0CqjMkOfD3CbkoJd3C887ueTYiA8vvD
 mZcVwKZJlWSuIqz5fY2MshrrzceyR0Io5cp31d1wWoA+7stG1dgX6wxREQ7Ezr/LZBPNXhryh
 9tNzBGUSeSQnDQb/cFw5FZ2daVXwh/9DhcuXMHh+30NnqzVCeEDwnRDclYpbYr/QLOFKlIFoi
 zOiBhA1Ad2vPtg246rgJPa519l8GD7+5moJmn66X5omhMmrkddJ8plri//4gp2uyKhKOZm/sT
 7PnBLvEdJdpiT6KMa/v/wqhb+QUlejdCRwtMxB6oH2H+tlxG5875+Rk5GZBpmfaK/GZIELIx1
 WaQEILRh7bwQuBTcx4u4kZSHVGfM=

>> Dereferences of null pointers are treated in special ways.
>
> This not a dereference.  It's just pointer math.
Do you prefer the wording =E2=80=9Cmember access through pointer=E2=80=9D =
occasionally?
https://en.cppreference.com/w/c/language/operator_member_access

How do you tend to describe (and detect) null pointer dereferences so far?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers#EXP34C.Donotdereferencenullpointers-AutomatedDetection

Regards,
Markus

