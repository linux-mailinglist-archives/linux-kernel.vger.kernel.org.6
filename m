Return-Path: <linux-kernel+bounces-318341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9096EC07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291B3B2218F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B614C592;
	Fri,  6 Sep 2024 07:33:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200A22087;
	Fri,  6 Sep 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607982; cv=none; b=IbZI/GiLfZkQp5aaCVxQABtFolWEyZB2himTfLMlJcLIyjeBKgB3ToI+QuJWU4V/ZNYe3UpIM2bAlAQWtqK4rWiz6eiaHSz1gLnyEhPi7yw7fKAMJm4sH+7qFnUXJf4L/AEalGfC91WuZpM7Z2a8gfbtDvyZITOIhJyX1XkXC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607982; c=relaxed/simple;
	bh=AB6M4h+5Wgjqeo6/50sRThvejlW9PnffRcLFdYXOE0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNji0uXoDIGiAfariZjU9QERv2vG5bk3UHmmO3zGtAxYb8YzPtCHF4+vuVcuV3/srTx9eVj3xpb/oW/kSJyISoGXWINdsM6cz+AbwkI4GdRYnLGNBPun7Ad9ltOJcQtNUSxQs5SEYnTEEAlwf6qgNEbCi6UVcijVYpE0rNU654o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A661C4CECA;
	Fri,  6 Sep 2024 07:33:00 +0000 (UTC)
Date: Fri, 6 Sep 2024 09:32:58 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Peng Fan <peng.fan@nxp.com>, 
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>, "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@quicinc.com" <kernel@quicinc.com>, 
	"quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>
Subject: Re: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
 virtual instances
Message-ID: <4p6rknakoojsjunwbakwzsyyymufhvim2kctdkexcrqfcphe2a@k7epaxvxmgn3>
References: <20240905201217.3815113-1-quic_nkela@quicinc.com>
 <PAXPR04MB84593380F220DEC7974058D9889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <9930c7b8-cddb-4c70-a283-8f0a09d6c30d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9930c7b8-cddb-4c70-a283-8f0a09d6c30d@quicinc.com>

On Thu, Sep 05, 2024 at 05:33:04PM -0700, Nikunj Kela wrote:
> 
> On 9/5/2024 5:25 PM, Peng Fan wrote:
> >> Subject: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
> >> virtual instances
> > Just wonder, what do you mean virtual?
> 
> Just a term to indicate that these are different SCMI instances within
> the same OS. In one of the series from Cristian, he used the term
> 'virtual SCMI instances' so I used the same term here.

That's indeed confusing. Virtual means not a real thing...

Best regards,
Krzysztof


