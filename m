Return-Path: <linux-kernel+bounces-348742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A2498EB49
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DB41C21F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1116139CE9;
	Thu,  3 Oct 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZp1dHfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E03A1C4;
	Thu,  3 Oct 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943402; cv=none; b=ssrr9EWqc/JWV77SBbizrYiEC1o4CRb2+JDKHF3OsLHTr/9LOyFui3ebgweF5i4XIp8Nc4M8neIEkc0adVLlME2jr0xZAbueVfs4UWS8DycpcbN55RJqea6N8tVjUCPQpVXIX4wbrCJ5tLTHuJSdMe8XwyQMuqFEDSRW2MWN254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943402; c=relaxed/simple;
	bh=ZTEWdM9EQnqfcAqKF0YW4sdRl+S6oYuc7nTQKkdVdR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSZeNpRJLCdbucCVqPP5+evZh6hzmo5O2Ao7TvRIb4mZdIDg+ulzfIISf+J8xyf3PYSMfY6NUztHxhmN1BulNxatWcNrRGu3ZaYrXQ0s3Iv9gx461p/admwa1pCqWZLWBvGwAiuzD9xSY4OXiJR3rBekk9ZuiqEld1q1u7YSd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZp1dHfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26D8C4CECC;
	Thu,  3 Oct 2024 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727943401;
	bh=ZTEWdM9EQnqfcAqKF0YW4sdRl+S6oYuc7nTQKkdVdR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZp1dHfeqxSSgekthOLOTBdngCa28+ZrfaepNDYBU0gKp8+j/geKT9bDPz8lNXSlm
	 lVC/F8oPScp1vFdAEcKB2K7e+T4LqLJTRLsw7JuxOUP1oCwroNkJBHB3ichvosytM0
	 2Vo/y5YvtbJ2AcZAgAePh2QY50fciQ4oSHZVgPot3bqegsAM+U1KLzb4VE3C0GRCLf
	 PRD8+BcU1eeWeFdQCS5KDTCTakZGmcYOuCv2sXKRwwaAmkynqY0i5It1kRyoMTYWQU
	 NjBxP4mizsmSJXDIS9/UWw55Q022jVZK6I+wL+bbZGwW+NxM2j2Yyw/X75Zn8qnv3n
	 EiDJ8sBb4FZgA==
Date: Thu, 3 Oct 2024 10:16:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <vikiazbwxih7l4qcpoc5lhm6q5xwaitqnytt24nmr3prsos3jc@773uozmdlj6e>
References: <20241002084023.467383-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002084023.467383-1-naresh.solanki@9elements.com>

On Wed, Oct 02, 2024 at 02:10:17PM +0530, Naresh Solanki wrote:
> Document the new compatibles used on IBM SBP1.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---

Provide changelog explaining what happened here, including what changed
that tag is invalid/skipped.

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


