Return-Path: <linux-kernel+bounces-432847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D189E50FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F6D18806BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE71D514B;
	Thu,  5 Dec 2024 09:16:28 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21917B506;
	Thu,  5 Dec 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390188; cv=none; b=UwyWVki+wISbmz6cYIplvuu9/6EJAYV6WnbQZ3oxPDLTJgUhEZy+xRLN+M06Q2WnbfitQ4EAQqsQq86RgXOTT2zTqF38xYw1H4JtTWVi0YE3NIYj4tA61/Y4SWn8ZJOVA0Ry3TLpAoCjJWH2o2feroyX5Wgf9nVsC0YnB8WgXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390188; c=relaxed/simple;
	bh=KR6V8m1cXgIKj/ZcrzRwqhEuWfcpHRkIZ6Mjsog20go=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlgAQVcd5w1VdKRoaoLV9cYoP99wrVx+iSkHyAbfrk20sLRuycAp7h3YlzrzNABAuJ4SZdbnj1sL5Z4BJVSZtpGAP54tlxKmYziNLbQ9UGZ+tieEJUMlXtQSz4+ardmpYhGXF7ldF/KfMk14FeMTCze+ZSKeX/ndGa4YQ6Aq6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4B59FvSQ084852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 5 Dec 2024 17:15:57 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 17:15:58 +0800
Date: Thu, 5 Dec 2024 17:15:44 +0800
From: CL Wang <cl634@andestech.com>
To: Rob Herring <robh@kernel.org>
CC: <alexandre.belloni@bootlin.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>, <ycliang@andestech.com>, <cl634@andestech.com>
Subject: Re: [PATCH V4 RESEND 2/3] dt-bindings: rtc: Add support for
 ATCRTC100 RTC
Message-ID: <Z1FvQEu-5Z68vJc2@swlinux02>
References: <20241127141939.1570952-1-cl634@andestech.com>
 <20241127141939.1570952-3-cl634@andestech.com>
 <20241203170651.GA1955995-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241203170651.GA1955995-robh@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4B59FvSQ084852

Hi Rob,

Thank you for your review and comments.

I will include the reviewer's tag in the next version of the patch.
As you mentioned, if a tag is received and a resend is necessary,
I will include the tags and update the revision to v5.

Thank you again for your reminder.

Best regards,
CL

On Tue, Dec 03, 2024 at 11:06:51AM -0600, Rob Herring wrote:
> [EXTERNAL MAIL]
> 
> On Wed, Nov 27, 2024 at 10:19:38PM +0800, CL Wang wrote:
> > Document Device Tree bindings for the Andes ATCRTC100 Real-Time Clock.
> >
> > Signed-off-by: CL Wang <cl634@andestech.com>
> >
> > ---
> > Changes for v2:
> >  - First version of devicetree bindings for the Andes ATCRTC100 Real-Time Clock.
> >
> > Changes for v3:
> >  - Used compatible as the filename.
> >  - Placed allOf after maintainers.
> >  - Replaced additionalProperties: false with unevaluatedProperties: false.
> >  - Added descriptions for interrupts.
> >
> > Changes for v4:
> >  - Removed wakeup-source attribute.
> > ---
> >  .../bindings/rtc/andestech,atcrtc100.yaml     | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml
> 
> Missing Conor's tag from the 1st resend. If you got tags and need to
> resend, that's not a resend. You need to add the tags and it is v5.
> 
> But don't just go send v5 now for that. Alexandre can add the tag.
> 
> Rob

