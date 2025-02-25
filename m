Return-Path: <linux-kernel+bounces-531047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46490A43B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D001684BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E807266B6A;
	Tue, 25 Feb 2025 10:22:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9F266582;
	Tue, 25 Feb 2025 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478925; cv=none; b=AOxJciYnyujJMzU9Bw6eEZQ/y3I4Ei8wStGCjq0fFOvtl81hDC17RyGO3reEx1C04Yfnpjg9CkjhjdndLKaljFdYs0eu18dwsbf0OeaG7Ta1eC5OJ/ZiFfP0fKoVp3p7aNdW1csODdJKv7C1M3VgDOhnk8ewAMKdmSN4mBOhioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478925; c=relaxed/simple;
	bh=igunqGICXsKr6OtW++2jbEjn+EWqjuNOIF9KWqLH9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/fl72GO3pi3v5sB7JSHUEfSHQPLs8Bdzw4IrVXPn+At2VrEwF+bcDtc/+l+NtBYdoI86cwyQg6DkcgiKDCrbDPNOrFaquoTqJSFun4M8ZdFTqzMZ0mfxixQ+qfcf20JBAwZFfFdSnduWP0CiR/0zcKanKb0GChGq8BL2Ldp7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC2601516;
	Tue, 25 Feb 2025 02:22:19 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E593F6A8;
	Tue, 25 Feb 2025 02:22:01 -0800 (PST)
Date: Tue, 25 Feb 2025 10:21:58 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Chuck Cannon <chuck.cannon@nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"Pengutronix Kernel Team" <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Message-ID: <Z72ZxspU3hfGZWez@bogus>
References: <20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com>
 <20250121-imx-lmm-cpu-v1-3-0eab7e073e4e@nxp.com>
 <Z5DhM1VLv2uCCVwT@bogus>
 <PAXPR04MB8459D4C2CA3D5AE58B2B509788E02@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459D4C2CA3D5AE58B2B509788E02@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Jan 23, 2025 at 01:30:43AM +0000, Peng Fan wrote:
>
> This is to manage the M7 core by Linux. I just put more documentation here.
> CPU protocol is also used by ATF to manage AP cores.
>

Good

> > Also what other CPUs are we talking here.
>
> M7 core
>

Are they referred by any other name in the system ? I reason I ask is using
plain "CPU" is too generic and confusing. At the same time using "M7" may be
too specific. I am trying to see if there is any middle ground.

> In general I would like to
> > explore the possibility of collapsing this with LM protocol. CPUs within
> > LM is LM's responsibility to bring up. And CPU can be seen as an LM for
> > sake of this vendor protocol. I am not get into details here yet before I
> > can understand what these CPUs are really in the system and why we
> > need this.
>
> Our system supports M7 and A55 in one LM, so A55 use CPU protocol to
> manage M7. When M7 and A55 in different LM, use LM protocol to
> manage M7 LM.
>

The LM(assuming Logical Module/Machine) is an abstract construct, it should
apply to even subset of components within an LM. Just wondering what are
specific reasons do you think applying LM protocol you have on those M7
CPUs alone in A55+M7 LM would not fit well.

--
Regards,
Sudeep

