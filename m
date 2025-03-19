Return-Path: <linux-kernel+bounces-567676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC5A688E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C98916629F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C09250C16;
	Wed, 19 Mar 2025 09:54:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441EC1AB50D;
	Wed, 19 Mar 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378059; cv=none; b=KXpDx67leCfjaa/xF9wqT7E131g773Q8MKLqdahE1PVrdUoopyfITzg7S2TSnfR7fgGonK6XiFPkmyCOCrwh1C8Y7NHj1gqf6CrtrcrrSL5HpbpSfkZLZI+zqs1AP0AwqA7cVo393AGKg06TMZ6eKbt5t/2Dd6UdaZ0li863yAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378059; c=relaxed/simple;
	bh=AnOGRXGgrFFLR8eD2QPQt4D1N8CkEu7pT4SS6OlZHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFnJO1kYCDdxLKYmfD7jUBvwvrTRZ2kh+uVidG5zBcisbeRu9G2rbQBn4MFLGc0vqVHQF2RlBDyns9aK13l9QJY4M3Sdyg6na+SocOAiRnU4dK/56ovHW/lr7KDcUgPxsUscZAYcMdR5vp+W3nSNyCJ2AeauIBOVUj4K3Xqr7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DCD13D5;
	Wed, 19 Mar 2025 02:54:25 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4AC3F694;
	Wed, 19 Mar 2025 02:54:14 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:54:12 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	<linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
	<devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 0/7] firmware: scmi/imx: Add i.MX95 LMM/CPU Protocol
Message-ID: <Z9qURBnqtvbNoZ7K@bogus>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
 <20250318082804.GA1326@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318082804.GA1326@nxa18884-linux>

On Tue, Mar 18, 2025 at 04:28:04PM +0800, Peng Fan wrote:
> Hi Sudeep, Cristian
> 
> On Mon, Mar 03, 2025 at 10:53:21AM +0800, Peng Fan (OSS) wrote:
> >i.MX95 System Manager(SM) implements Logical Machine Management(LMM) and
> >CPU protocol to manage Logical Machine(LM) and CPUs(eg, M7).
> 
> Any comments?
> I am thinking to address comments and post v4 after 6.15 merge window close.
> 

Sure I will take a look later this week or next week.

-- 
Regards,
Sudeep

