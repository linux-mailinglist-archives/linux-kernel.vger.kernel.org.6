Return-Path: <linux-kernel+bounces-535905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791CCA478C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B93B3B3FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8E227E96;
	Thu, 27 Feb 2025 09:12:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62306227599;
	Thu, 27 Feb 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647545; cv=none; b=Ff4ZjdYwh6HzSUN9gkdcaW3ntb4navV8XM+K46Kd6bow5Q0vh8wzocuE74ttSpBQeJklWQ5cHEAOPOPXZe0ecvO5/jlelHO5G0hg13I5CViSnuaTvgEs6t/yWv7+int4qVLj+DOb/KlfQPETMkA6+C6GshJenEfH7u2TiKS/PW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647545; c=relaxed/simple;
	bh=l/ugFLJaIKamHn5kr0KvgF8RGwpPoaLUQqqZx88pHY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePNvnAg49+CvK2ghBgYd5dxdpUuRL/vufix7mOjO1lxESZ1CT9AKALN91RlPVmkWeBlFMkDOfqYMhpd8VzhiIg4FpCeVp+UzZb/tv4F4Dr8ndqYHW5rgfDqFGQsAEQfSfB8QOSCfD7l3J432qZjb855OvanLymW/CecDf3BxulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145782BCA;
	Thu, 27 Feb 2025 01:12:39 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88B543F6A8;
	Thu, 27 Feb 2025 01:12:21 -0800 (PST)
Date: Thu, 27 Feb 2025 09:12:18 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, <cristian.marussi@arm.com>,
	<saravanak@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <Z8AscmP2O_HjEnsL@bogus>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <20250226160945.GA2505223-robh@kernel.org>
 <Z79NOeyWzfRio8qs@bogus>
 <20250227031551.GC11411@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227031551.GC11411@nxa18884-linux>

On Thu, Feb 27, 2025 at 11:15:51AM +0800, Peng Fan wrote:
> On Wed, Feb 26, 2025 at 05:19:53PM +0000, Sudeep Holla wrote:
> >On Wed, Feb 26, 2025 at 10:09:45AM -0600, Rob Herring wrote:
> >> On Wed, Feb 26, 2025 at 05:44:56PM +0800, Peng Fan (OSS) wrote:
> >> > Quote Sudeep's reply"
> >> > I am not blocking you. What I mentioned is I don't agree that DT can be used
> >> > to resolve this issue, but I don't have time or alternate solution ATM. So
> >> > if you propose DT based solution and the maintainers agree for the proposed
> >> > bindings I will take a look and help you to make that work. But I will raise
> >> > any objections I may have if the proposal has issues mainly around the
> >> > compatibility and ease of maintenance.
> >> > "
> >>
> >> This all looks to me like SCMI has failed to provide common interfaces.
> >>
> >
> >We can look into this if having such common interface can solve this problem.
> >
> >> I'm indifferent. If everyone involved thinks adding compatibles will
> >> solve whatever the issues are, then it's going to be fine with me
> >> (other than the issue above). It doesn't seem like you have that, so I
> >> don't know that I'd keep going down this path.
> >
> >Sorry if I was ambiguous with my stance as quoted above. For me, 2 devices
> >pointing to the same node seems implementation issue rather than fixing/
> >working around by extending DT bindings like this $subject patch is
> >attempting.
> >
> >If you disagree with that and think 2 devices in the kernel shouldn't
> >point to the same device tree node, then yes I see this is right approach
> >to take. ATM I don't know which is correct and what are other developer's
> >include DT maintainer opinion on this. I just didn't like the way Peng
> >was trying to solve it with some block/allow list which wouldn't have
> >fixed the issue or just created new ones.
> 
> With compatible string, no need block/allow list anymore I think.
> 

I completely understand that, I was referring to your earlier alternative
solution to this $subject approach. Sorry if that was evidently clear.

-- 
Regards,
Sudeep

