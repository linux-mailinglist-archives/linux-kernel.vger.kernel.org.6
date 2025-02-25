Return-Path: <linux-kernel+bounces-531260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD6BA43E40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C959420569
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFBC267738;
	Tue, 25 Feb 2025 11:49:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686EC14A4E9;
	Tue, 25 Feb 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484148; cv=none; b=lNyq5DNKnjN2qyQeiYbc+Uz+jjICjhrCuVTPPSablHr6P+11FQ+Btdkxm8LZWkp75COSWiJ/QfhE2nHA67fjJvZZJpu0D/NmnyGoaxkTudOAxzDqkUacWHf78pJAullKVH8TY2j/eub/QlQLKo0BTvt1Bs9VRuRmWrXD26NJeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484148; c=relaxed/simple;
	bh=RMX/vLzmRR+t1Z1tZJHPqlfhsfdx45TI3dWdcL1Fabs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNuk7IVD/YGMXsZdX8aToao8Vw6WbmlmQVSgTqG3KQQWD1q64jLocgtfTMQJtDqNrLZY/wqlKHyBS26bf4qoVAYAkMIf4mjWpQ1hs122Q7wYRNgowDPMd0jUDFNAJdLfEo2O5sahYa9g/PpMeTKIzCiJxCsIJhxEfXh8qhJkxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D5E71516;
	Tue, 25 Feb 2025 03:49:23 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918D43F5A1;
	Tue, 25 Feb 2025 03:49:04 -0800 (PST)
Date: Tue, 25 Feb 2025 11:49:01 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Chuck Cannon <chuck.cannon@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Message-ID: <Z72uLenEmCwDCV5c@bogus>
References: <20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com>
 <20250121-imx-lmm-cpu-v1-3-0eab7e073e4e@nxp.com>
 <Z5DhM1VLv2uCCVwT@bogus>
 <PAXPR04MB8459D4C2CA3D5AE58B2B509788E02@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z72ZxspU3hfGZWez@bogus>
 <20250225124203.GA31590@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225124203.GA31590@nxa18884-linux>

On Tue, Feb 25, 2025 at 08:42:03PM +0800, Peng Fan wrote:
> On Tue, Feb 25, 2025 at 10:21:58AM +0000, Sudeep Holla wrote:
> >On Thu, Jan 23, 2025 at 01:30:43AM +0000, Peng Fan wrote:
> >>
> >> This is to manage the M7 core by Linux. I just put more documentation here.
> >> CPU protocol is also used by ATF to manage AP cores.
> >>
> >
> >Good
> >
> >> > Also what other CPUs are we talking here.
> >>
> >> M7 core
> >>
> >
> >Are they referred by any other name in the system ? I reason I ask is using
> >plain "CPU" is too generic and confusing. At the same time using "M7" may be
> >too specific. I am trying to see if there is any middle ground.
>
> "CPU", if you mean the protocol name SCMI_CPU, there is no good choices.
> I could add a note that "CPU indicates the various cores of i.MX SoC,
> one CPU represents one core"
>

Just a wild suggestion, you don't have to take this. Can it be called
SM CPU or something ? If you can't change the firmware documents which
is understandable, I suggest we call it sm_cpu or something appended before
cpu to distinguish it from the AP CPUs on which Linux runs.

> The documentation origin from https://github.com/nxp-imx/imx-sm
> hard for me to drive a change to use other name.
>
> Anyway if you have ideas, I could bring to our firmware owner.
>
> >
> >> In general I would like to
> >> > explore the possibility of collapsing this with LM protocol. CPUs within
> >> > LM is LM's responsibility to bring up. And CPU can be seen as an LM for
> >> > sake of this vendor protocol. I am not get into details here yet before I
> >> > can understand what these CPUs are really in the system and why we
> >> > need this.
> >>
> >> Our system supports M7 and A55 in one LM, so A55 use CPU protocol to
> >> manage M7. When M7 and A55 in different LM, use LM protocol to
> >> manage M7 LM.
> >>
> >
> >The LM(assuming Logical Module/Machine) is an abstract construct, it should
> >apply to even subset of components within an LM. Just wondering what are
> >specific reasons do you think applying LM protocol you have on those M7
> >CPUs alone in A55+M7 LM would not fit well.
>
> We have internal mail "NXP-ARM SCMI OEM extension" between NXP-ARM that I
> could not post here. In that mail, LM is explained.
>

Fair enough. Please don't share any info that can't be. I understand.

> It is the LM protocol design that it only applies to the whole LM.
> If the LM has A55+M7, A55+M7 will both be handled.
> If the LM only has A55, A55 only be handled.
> If the LM only has M7, M7 only be handled.
>
> When M7 + A55 in one LM, using LM protocol to handle M7 will make A55 not
> work properly. The current linux usecase is remoteproc, that means
> stop M7 will make A55 also stop. So need use CPU protocol here.
>
> When M7 and A55 in separate LM, using LM protocol to handle M7 LM works well.
> The usecase is still remoteproc. In separate LM, A55 CPU protocol will be
> blocked to handle M7 CPU per firmware security.
>

Thanks, I am now clear on LM has A55+M7 and M7 only. However your above
statement relating to LMs with A55 only is not clear. If they run Linux,
they just need to still use PSCI and this CPU protocol shouldn't be used
to control them. Can you clarify on that ?

Other than that, it looks like we do need both LM and CPU. Just asking
all the details so that if in future we have a similar need that needs to
be a standard protocol, it would help us better.

--
Regards,
Sudeep

