Return-Path: <linux-kernel+bounces-385022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA679B317C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FE11F2294A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949091DBB19;
	Mon, 28 Oct 2024 13:17:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1E3D3B8;
	Mon, 28 Oct 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121439; cv=none; b=uPYMxnXiZdhPVJdAOtEdOSsMJVv0tn0lSVr+dBoanWbyiYOMJ8elYS+PDrcJKvlTNcmCKOCOBL3u6z9iYG4BrH6af1Rsp+fNAXEZ1uGijag1TV66otjuEFHltZDCa7PgKnqalvSORTO43/N858DuT1gKjdojrhCewv3oyUjtGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121439; c=relaxed/simple;
	bh=qqcVmzHzB9yCfovyypdgFMBMFpEl6TUC0BH0Gs2NJpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOLvif9H84eecfiodRSMh/O/BMRrHHooJYrh7AG80DdyDzQl9hC/+Ec2xhZQaV1vSNIBfJ4YiQVPFt4DyZRIba0RIBc3+royxLtR7XefhogDa90wpUUgj6DHXCpzB99Ulcqg0sWxe1afJYMXqExabIGTcWw8FPCAiXJ3iYEJdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7710D497;
	Mon, 28 Oct 2024 06:17:45 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70ABD3F66E;
	Mon, 28 Oct 2024 06:17:13 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:17:06 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, quic_nkela@quicinc.com,
	dan.carpenter@linaro.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: firmware: arm,scmi: Add missing
 vendor string
Message-ID: <Zx-OHucz4xOL8eyj@pluto>
References: <20241028120151.1301177-1-cristian.marussi@arm.com>
 <20241028120151.1301177-7-cristian.marussi@arm.com>
 <Zx-CHlAb61FWdzkA@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-CHlAb61FWdzkA@bogus>

On Mon, Oct 28, 2024 at 12:22:54PM +0000, Sudeep Holla wrote:
> On Mon, Oct 28, 2024 at 12:01:50PM +0000, Cristian Marussi wrote:
> > Recently introduced max-rx-timeout-ms optionao property is missing a
> > vendor prefix.
> >
> > Add the vendor prefix from the original committer.
> >
> 
> It should be "arm," not "nxp," just because NXP happens to introduce that.
> It just highlight that the property is X vendor specific and here it is
> associated with SCMI and specifically Arm SCMI, so "arm,". If for some
> reason nxp or any other vendor overrides this definition and need to add
> additional property then they can add their own vendor name into that
> property.
> 
> If there are no objections, I can fix it up when applying.

My bad. Sure go for it.

Thanks,
Cristian

