Return-Path: <linux-kernel+bounces-269324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0594318F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA51E1C2151F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592C1B3736;
	Wed, 31 Jul 2024 13:58:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062EE1AED53;
	Wed, 31 Jul 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434315; cv=none; b=WhNO2uAh0cddAYxuHAtSBIdKFous9QtmpVYS2IS1Y/4vBm/vUmhn7xNYEfud/FrQDOd+/5Oz6MRq9whU922w4xJIpNZNc6YwmiiV6s4bhEIgg0zanSI+vPGmXxdIoI51x693bjBrNZPq8EmlhkCxlCFoDuvKi1tpPJgBKpTLevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434315; c=relaxed/simple;
	bh=LRlHURSShgZRkgC4QKjOhJNgXBWEXfSYxZZuu5IANH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMjq7TPk2tIgvei/vbVF+N6GM3NiBR4ynqb5LkJCaXEygFn3j+piYIiLUt0XAcEKdwBRId9tSh2RsEI81vG65KXC9k4SEvF3uddlqvnUOozFehgB+A3SgOlbIwAsw8P+jyKixp29UeBK+wahdtodKy2izRyHmP3fhC6SSTD3iWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C92EB1007;
	Wed, 31 Jul 2024 06:58:58 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A71863F5A1;
	Wed, 31 Jul 2024 06:58:30 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:58:28 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 0/6] Add SCMI transport descriptors
Message-ID: <ZqpDBCDnzgGwAlL7@pluto>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <PAXPR04MB845979C704A02CF0DCAEF39D88B12@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845979C704A02CF0DCAEF39D88B12@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Wed, Jul 31, 2024 at 01:13:14PM +0000, Peng Fan wrote:
> > Subject: [PATCH v1 0/6] Add SCMI transport descriptors
> > 
> > Hi,
> > 
> > this small series is an extended version of this recent, already reviewed,
> > series [1] posted by Peng to add a new arm,scmi property to describe
> > some platform-specific SCMI timeout constraints.
> > 
> > On top of that, this adds 2 more properties to describe a couple more
> > platform-specific transport characteristics.
> > 
> > To minimize conflicts, the whole series is based on top of another
> > recent series, which represents a rework of the core SCMI stack to split
> > SCMI transports as standalone drivers. [2]
> 
> For the patchset,
> Tested-by: Peng Fan <peng.fan@nxp.com>  #i.MX95 19x19 EVK
> 

Thanks for testing.
Cristian

