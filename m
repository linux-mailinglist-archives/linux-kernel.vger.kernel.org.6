Return-Path: <linux-kernel+bounces-267345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD8941084
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06091F25E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0F619DF73;
	Tue, 30 Jul 2024 11:31:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49539187340;
	Tue, 30 Jul 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339111; cv=none; b=hXo0daMW+8AN5ugIkg3IGbOwHD9rWCLADBXR8I+JfZRD+s+DhT/4K1sNUw4pKFFGnUbznSlvynTvKf+HGdzr1djGIVs3bOs2Y80yZxreB2LkwP7qfdJIbl5aK7jsrtQQguikvpgZ0deDJvfhHk4v/KggWtKPDyRxBclNU14vWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339111; c=relaxed/simple;
	bh=PYKJW8uTYgNgrU6ePn1bj1o/m8pOVwYi6KJtcmykvYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHHmq5TFGb0e9ODEF7dqu1b4j23qI3KAfCtJegEeTWcfkPZjA7z7Lb8nMJTZ0YcTRqvgqMaAf91/1GBoE5bPirNP4HC4GCu0PjOubHcPnkTcZ10jQj2perHfqS7zxGiy9IidmGg62ibZ3hHGoGJdCVzPSARVDe88Cr65v6DfPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 493621007;
	Tue, 30 Jul 2024 04:32:14 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3053F5A1;
	Tue, 30 Jul 2024 04:31:46 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:31:38 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value
 from device tree
Message-ID: <ZqjPGvTgtosWQTzM@pluto>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
 <20240709140957.3171255-2-peng.fan@oss.nxp.com>
 <PAXPR04MB84594F4271F68D9072BA0C0D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84594F4271F68D9072BA0C0D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Jul 18, 2024 at 02:24:15AM +0000, Peng Fan wrote:
> Hi Cristian,
> 

Hi Peng,

> > Subject: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout
> > value from device tree
> 
> The binding has got R-b from Rob, will you pick this patch in your next
> Patchset?
> 

I am going to post a new transport_drivers_V3 and, as a separate
series on top of that, your latest "max-rx-timeuout" DT patch as
reviewed by Rob, plus the related new logic based on transport_drivers_V3
and a few more similar changes as requested by Nikunj.

Thanks,
Cristian


