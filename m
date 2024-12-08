Return-Path: <linux-kernel+bounces-436414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C039E859E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7DA281568
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645514F102;
	Sun,  8 Dec 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBpCs4qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59C43AB9;
	Sun,  8 Dec 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733667989; cv=none; b=kUiFUbXvWo2eQ+ieL4wrUYgsxAetdKOx3TLwnmqA0/+L9hxrX28Z+dXqTrckskPC8xXeuqR2zVshJkJVO1Hfnp9/8uBuM0tgCR6B2vKex8BQJ3R8HxBxoRrl/+r1YWfqBtDa1rnTElHPXV3osKBcaSr8JO9fC1l+0FBEEPK/4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733667989; c=relaxed/simple;
	bh=0Uv3eFUIrpjiAPwURX+ObvFZr92Jp4bxRVgE4ZCOAtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJKvhD5PaJQiZ5ythc2kPS87NzWXoJBV+8W0wGvxntisEQvL9M4Gem37+7bP/FrANKBAwnmnLgw1RCQHTZH0C77cCBw+Ds537rh+jImpNkyU/Hs83A53BZnKSeJ1JlpF3NGdFyaH4KTDS8Wacf4aIKjEbZH9TjKfLX23JGPZJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBpCs4qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D8CC4CED2;
	Sun,  8 Dec 2024 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733667988;
	bh=0Uv3eFUIrpjiAPwURX+ObvFZr92Jp4bxRVgE4ZCOAtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBpCs4qobxen0mS1LfFy6sl8lUkyIz3KPBro9aLGNFBUWQbbGVpXC0f399ElpsIMA
	 /gfDKmaEGD82FgRkcbBnja3sPtGfjrnMZ+hI8IJdfRcsK8zh4PAnx1GwCw7sCOPCck
	 8ndJbV4k98jzKql0TKeAzPjh92WH2BGrnaLp2eo7UjK4MWFjELnRkhSnd4Kc3ANIUy
	 QW7O1py5XqOhJrGGnTKH1oYYox3r0WXxzdxigid5Mfj4fqNGAJGbNgt1hwCgg6mcQv
	 NrACxhJMeI4CJGWFc/hTIaoO9vf4B6m+qeT/0ZPfk2BgPO6zzbbnurLbTE3YyRTpC6
	 RPos9wfMQKxdA==
Date: Sun, 8 Dec 2024 15:26:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: niravkumar.l.rabara@intel.com, devicetree@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Message-ID: <ugcx6muozaven6lolhzpk5mvrt5fncoaahnsx5lbdsaurid4mc@i4qflh2edqnh>
References: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>
 <87mshawhta.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mshawhta.fsf@bootlin.com>

On Thu, Dec 05, 2024 at 11:22:09AM +0100, Miquel Raynal wrote:
> On 05/12/2024 at 13:33:50 +08, niravkumar.l.rabara@intel.com wrote:
> 
> > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> >
> > Convert cadence-nand-controller.txt to yaml format.
> > Update cadence-nand-controller.txt to cdns,hp-nfc.yaml in MAINTAINER file.
> >
> > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Looks good to me, but I'll wait for binding maintainers ack ofc.

There was one, but author ignored it.

Best regards,
Krzysztof


