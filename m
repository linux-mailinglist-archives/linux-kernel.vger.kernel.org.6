Return-Path: <linux-kernel+bounces-215320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C190911E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCB028515C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B426ACC;
	Fri, 14 Jun 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPMSaFf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4717BCC;
	Fri, 14 Jun 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385072; cv=none; b=GK5vF+vH6GyIumTWTLDgkrInjEdhNTtwxTqf2OLsKv6eMAzw/ehe2dGjdAVmmpWSkcsDUY+gT8j1eVU21zVbCmTx499ZX84Ch1uNdHjHY28aBWghdro0hx5OWZvxPLpIsEdgXhbXbZ8nYua3D8XkcgH+Jj+L+jywOSkRc6DpjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385072; c=relaxed/simple;
	bh=awixWxSVolly/G4sfdq76SERrN6zQfn9KBvueL0sexg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC/yiISbP+Nd5XZ77bT0o+EgvuVxnTck/oxhvZbIrGvQ0eNFBLsWL2aeBnwIL+4v6y4uXcVs3YsJ1mjywI6bPVP4cmsRPbu54AU0l95N5a/+agv4nXJDjvcIBluL1WN+DzVuXUIfJwmlFHxMXea1PzjCfSr0RTV4NAK43kxIdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPMSaFf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1743C32786;
	Fri, 14 Jun 2024 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718385072;
	bh=awixWxSVolly/G4sfdq76SERrN6zQfn9KBvueL0sexg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPMSaFf1NA7USL06HtjJujv3wlLcTT1Z2LcYSULbG+mXA4xcmg9JUvgNmLaR6p03c
	 KsVDREL9DhbuclNBh2yNUTy9qGFL8ahKeVsCRHksIBdolVlqxk6j1ItUoZJSkdKYE8
	 b/q6hEbfLnHP+5NEWkhw6zRDUFxAJtMOxTBkocMQ22z8AaNscY0Su2Zma8FgxyZroq
	 Q7KqOU6WTBybytIe5QqJ8yggyM5+ZoEOUgp6fk4vTYgQoRPGW96WOKJm//j8t9rWKq
	 mukoB/DMpJgIPSQrnifFi+WGteQpYJhRR6+SQeFLBJg/ZKnw743rik5f9hNO2NdmeJ
	 W+LTRw4xBnhwQ==
Date: Fri, 14 Jun 2024 18:11:07 +0100
From: Lee Jones <lee@kernel.org>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: andre.przywara@arm.com, jernej.skrabec@gmail.com,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	macroalpha82@gmail.com, ryan@testtoast.com, wens@csie.org
Subject: Re: (subset) [PATCH v3] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
Message-ID: <20240614171107.GL3029315@google.com>
References: <CADomA48VNZiDPVKrUTq6h8SMBO-GA5HUGXXRRA9jAQnPKyESJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADomA48VNZiDPVKrUTq6h8SMBO-GA5HUGXXRRA9jAQnPKyESJg@mail.gmail.com>

On Fri, 14 Jun 2024, Philippe Simons wrote:

> Tested on my RG35XX-H, v6.10rc3 boots with the patch applied
> 
> Tested-by: Philippe Simons <simons.philippe@gmail.com>

It looks like the way you replied to this mail failed to attach itself
to the original thread, so I have no idea what this tag applies to.

However this point may be moot since, by the look of the subject line,
you're attempting to apply tags to patches which have already been
committed.

-- 
Lee Jones [李琼斯]

