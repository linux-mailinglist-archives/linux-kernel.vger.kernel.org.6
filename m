Return-Path: <linux-kernel+bounces-175633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9E8C22E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7365282B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C916E862;
	Fri, 10 May 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B+7SKH4l"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3421340;
	Fri, 10 May 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339562; cv=none; b=oICWDdnbDGrecbm47OmwLXFedCXtoYEX7RaMlY+2V83skyDmCGuvQn7X/zwQ+1d1Siul1XlnZ0vVfhSd1ne5jL4/UrWJm0AsqpLqjn6vGmy7V0QmixvW3qiti0e99aP3udvQQTryov2wCbKytWh1O7AuRCOnHrRClE8C5xVNCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339562; c=relaxed/simple;
	bh=I9klVlPuitLf8Kzw1WYldY7WjUrzz4F6V62ejcvIfso=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Px1fYYUZvUZAzEr0p+VCteFT9POCpHwsnsZh9c9qMKhWfXOdShEtVCNlZt5/IO8T1Gh5vOlpAiwKXVAmIH4trcuE1K7M9Jse2LUxIEx1Foys+CPxXsXv8FLeBpvcVqvCVtEHYz9QazKuRgyaKy40I1ZgOXxOPwr7hd2jkOfzDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B+7SKH4l; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715339548; x=1715944348; i=markus.elfring@web.de;
	bh=I9klVlPuitLf8Kzw1WYldY7WjUrzz4F6V62ejcvIfso=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B+7SKH4lBtukg1ck2oIxzN4vnk80FfuUfFwj+V5r7wXs+A92+6sRz4AZrEAi62e/
	 krxbUR+4US6qp0gvw9bbHCSw0lKj6hiWviSl4G/mfo+48/+5RRokHboDvDZ2c8XDN
	 97WjY+GSLvIeN0H41n2MkL7/ybAbZYrHfdvq3BluyWY2U8ycrqhviyEu+bqULM5w4
	 DwnV1gSDFl7CzwoZzRx8uGeb9xACVY0U+pfuAmAfsGNaLZYEp/rzwrFh/ihISMCcI
	 EgJRturRoigVlcwJ253BkzSPWamqY2lWgBIsEMC5MFAXk04iDvvRqmoZrY2lF+PKN
	 x0XAsvH+6kyNC7Z7VA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1sjnDm1ts6-00tG15; Fri, 10
 May 2024 13:12:28 +0200
Message-ID: <50d10f0b-d108-4057-be9c-a90e2398e810@web.de>
Date: Fri, 10 May 2024 13:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thorsten Blum <thorsten.blum@toblux.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240508094628.308221-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH] platform/x86/amd/pmf: Use memdup_user()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508094628.308221-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rkzafPnxwMJ01b5SowshcheSLDCTpRRagb8m/lxjo6P+yIQuUXZ
 5eZ1QvLa2lGEEkeoBv1h1AXbFGPDotI8/r/pi9BpwzmfNbEbyW1AC8EWQ6Xff8tyxH1o5fd
 bKmkb0KTxYhSoV19AFS4tIEBMIXOm8Sz4lYj5DSVgd8xoaySJCSPywrIGvRdO5nOqUNvGDN
 y8zqfhbyHlubUIoBLeKTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rzIe93eWvF0=;aYkUJd6p6D2P5UVVmfqDLcTzpGf
 iw77QzfSs5z7SGcM2NaY9AMxaf3Ux5VBacsJ0h8zT+ryL1qmRz7oB+scl7mz7Qsx2Eet+xMBA
 wHiwLVM6irCVDYIvgBHt4w1xE0hjZrleT37LKWxflWXwsLBXoxKGXi/n1gh3/m3PCDit51WB5
 UsP/xv+uMDUXlI89x4bBfLcXi/LMQkoQVpnyyS/XWTV2qVMfDB4lQ97t4zGYkrjEASNgJCpS+
 +lCV3JrlPLTszoEOiyuhinRLXlUCmLjZquSljSqEmaEIEAUQTJi0Gbw9ORTxp+AV1E4HcEZ42
 Jrvg3oM9C0DMFAXvv4FAY4XJBmd3MYrGRyi1zdo28kqCQD6qG0LsVFyNm+kTcJ/Bs2i91BMOS
 PaUp2fdP/kSl2X0NfB64DCa0G880Sf5EaHmsUhfkU4brr7E+UL4b0c4DaOjOT5FIV3dgnRuSB
 a7AER4srizX6y2z/OS1/ybASSXVv1n70xWtq0F04+6sLnF/zv7sXFy+20liMIWxtaOkGRXpFW
 At+BqHyuSZq42Z6VwHe1SO5slP8tO7eAXDNJzrvNriFMWa13LLNIdpw8a81wfbOs7v6O4lxin
 9i2xhsnWTrS5OaGUbB4RfCxJvYBNqwabt+QDcMk7J92XOxd9fO1G0Ed6yuyaSnE4miWn7gkh5
 gN06rVSJsaqNe4bSbjZQ6sR6JWpZwHeBEkwYV4WzU98RxDufpsB7hxZARQqYrTe7ZmOx9Q4bM
 bDgBenGX+HW/bmI3KujIedtRAPOI5CJXvZQS2Gd0N8kG9wo2/Bi10yBD6h5d/LolZ0/ds0Wge
 xViMdNj6Ko7Bcj2pRq29yTx6rz2GwE2J7SckQBTjO85XU=

=E2=80=A6
> Fixes the following Coccinelle/coccicheck warning =E2=80=A6

Would a corresponding imperative wording be more desirable for such a chan=
ge description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

