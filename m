Return-Path: <linux-kernel+bounces-403867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E89C3BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CE61F2100F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F518453C;
	Mon, 11 Nov 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dWIWUSEZ"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8118594A;
	Mon, 11 Nov 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321083; cv=none; b=dLll2OGOyFqXxbNUkyDxX2XkQMUrCAKds8om4MN70bEt5ZqMizO6J0JQLMQm4uSGFdembyPLSPrAzPh3ZZQilMmtcFNTt7MS5f5jh2SOwACq3kZ7XaXW9yvPhZ5K8pTZakhUUID+INAbFrL3++mzTLcPVLHMHFCJxr3yNphl9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321083; c=relaxed/simple;
	bh=ZKQ7GVkeqUob/khkwvundJ6JdgGPdQEfhXUdhRs1FwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjhYQFJRcn/Qr6gOyZ20hTBS1G3WygSrYrSe5hGnSRJzGpDo1fbWf+Cvd3pw62ul5719h5O3TJ7LO+ksiA3rTeU34Fr9MEuM2zhBUQrsI1XV7jcg/XoMlFFeXWwpZlrDlyR78pXsd/eK8uqd+RggUu74rhGmzkSVulzi4RTFUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=dWIWUSEZ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ydWcSWI2vdusMYOZVZQTuPuP5niMzB8uG4sljUSYqD4=; b=dWIWUSEZNVfIINixABLQEzq+zA
	WWLRJ6HpmXQH6J6HClEaRklxK/tQr/4vk6jit2+CGOCA2utIgAVnfweyQrXwSyGbawC/WJ8KXxvRY
	hXWHq2qgdGe28sKZ52xHP6RS9reALiuQjyeUwbMYJscBryziZhroIYWYEaA5Ka6pzHl/Sed7bLMDd
	aAtq189XePapmYQS0sf6d+LQi//G31xTpmLRbbuOAnU3ycAIL24lLSeHx2T+ZdlpXIk1My1D+TcLl
	dGi9sthaYGbodGMFNxBm90dbuBpmRmtPkHjLq4m4oeknSfDZCh9EScM0zYCjcqg1z7fuS/NLNVlAO
	CwDKU2Tg==;
Date: Mon, 11 Nov 2024 11:31:17 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Rob Herring <robh@kernel.org>, lee@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sre@kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm
 instead of MOhm
Message-ID: <20241111113117.2392d4d8@akair>
In-Reply-To: <bf50b6c0-af1a-4c7f-9c3e-ffbd3da87a80@gmail.com>
References: <20241029111112.33386-1-andreas@kemnade.info>
	<20241101192705.GA4062121-robh@kernel.org>
	<bf50b6c0-af1a-4c7f-9c3e-ffbd3da87a80@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 4 Nov 2024 08:06:53 +0200
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> On 01/11/2024 21:27, Rob Herring wrote:
> > On Tue, Oct 29, 2024 at 12:11:12PM +0100, Andreas Kemnade wrote:  
> >> Apparently there was some confusion regarding milliohm vs. megaohm.
> >> (m/M). Use microohms to be able to properly specify the charger
> >> resistor like other drivers do. This is not used yet by mainline code
> >> yet. Specify a current sense resistor in milliohms range rathes then
> >> megaohms range in the examples.  
> > 
> > milliohms?
> > 
> > rathes?
> >   
> >>
> >> CC: sre@kernel.org
> >> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >> ---
> >>   .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
> >>   1 file changed, 7 insertions(+), 6 deletions(-)  
> > 
> > Looks like rohm,bd71815-pmic.yaml has the same problem.  
> 
> Yes! Thanks for pointing it out. I'll wait for a while if Andreas wants 
> to fix them both at the same go. I'll send a fix for BD71815 if I've not 
> seen one in a week or so :)
> 
There is more debris left from an apparently copy-paste-modify process
from bd71828. That should be checked. At least there are several
occurances of the BD71828 string in there. So a brush is needed.

Regards,
Andreas

