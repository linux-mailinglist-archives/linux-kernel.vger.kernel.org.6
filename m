Return-Path: <linux-kernel+bounces-421042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EE9D85FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454C61696B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF891A76B5;
	Mon, 25 Nov 2024 13:10:19 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E134567D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540219; cv=none; b=BO4339JlpGsb5Tm6LTT0jBK+94a22kaVYhb6PyWHB9ZJv6WsnEub8Wan1cVDfkgG/sKbdsGIj3x//pkHfQW7doeAosB3OhMJWooUwmGm0bvT/e5kX0UJFjtYjwC/TXgd2nRx8AgjV93KBZbHyBRQi29C0+AhJiZ7xCGptKMjwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540219; c=relaxed/simple;
	bh=13F4cEGHqjK2B5MOk8zbRLecZrSMzPSQPAXtI1E1kiU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOv40yKyhP7OWb5A7AsZhb4DeoNZbkCjoxahMyNIjK+6YRL5/rtAqNHJDaRWsjnY9v58jOb2HwezIoKvuFf4H/hOEGtZ1YQHxm9cmxYIYnVlit95gyDckVCmG7K9+UNU/jsLDkaj2XdiqzDcZcr84gX3aUZCERTehQmQiVsRK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 4APD5pUW036185
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:05:51 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4APD5Pco036124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Mon, 25 Nov 2024 21:05:25 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 21:05:25 +0800
Date: Mon, 25 Nov 2024 21:05:19 +0800
From: CL Wang <cl634@andestech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, <cl634@andestech.com>
CC: <alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: Re: [PATCH V4 RESEND 2/3] dt-bindings: rtc: Add support for
 ATCRTC100 RTC
Message-ID: <Z0R2DxMip5eQeuv8@swlinux02>
References: <20241114140023.3534980-1-cl634@andestech.com>
 <20241114140023.3534980-3-cl634@andestech.com>
 <df431962-e8b6-4e77-aff8-1a547edcdf85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <df431962-e8b6-4e77-aff8-1a547edcdf85@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4APD5pUW036185

Hi Krzysztof,

Thank you for your feedback.
Regarding your comments:

1. I will base the patch series (v4) on the rtc-next branch from
   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git to
   generate the new patch series (v5). If this branch is not the correct
   base for the patch set, please let me know.

2. Concerning your previous feedback, I have already addressed the points
   and mentioned the changes in the changelogs of each patch.

3. I will use scripts/get_maintainer.pl to obtain the proper list of
   recipients and ensure that all necessary individuals and mailing lists
   (including the Devicetree list) are included in the next submission.
   I will also evaluate the use of b4 as suggested.

Thank you for your patience. I will submit the updated patch series soon.

Best regards,
CL Wang



On Tue, Nov 19, 2024 at 08:44:09AM +0100, Krzysztof Kozlowski wrote:
> [EXTERNAL MAIL]
> 
> On 14/11/2024 15:00, CL Wang wrote:
> > Document Device Tree bindings for the Andes ATCRTC100 Real-Time Clock.
> >
> > Signed-off-by: CL Wang <cl634@andestech.com>
> > ---
> 
> Never tested.
> 
> You keep ignoring feedback - do not respond, do not address, do not fix.
> 
> NAK.
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
> Best regards,
> Krzysztof
> 

