Return-Path: <linux-kernel+bounces-386088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1259B3F03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215F228394C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9B6FB0;
	Tue, 29 Oct 2024 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aI6GJFX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934044A2D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161244; cv=none; b=hWKhst9s45assL4NYyIDgj+FkdjYQSjz0wKnYmWU/eTcrYGy4VrSTm7NDdaUyHc11eL65uMxVse21G3t9gGaoOgSAxvUvlwBGq2UW62x+eyHy2Keid6mOTmMcJkCCW8oMB1xi6BYKey16xHXaSI7SIgtnNVn0tyoUeOoWGnPhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161244; c=relaxed/simple;
	bh=0RcBKxUNAnH20HyktGHycqKfexsnOgzeNXbbOuBOHYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8hKyf/BdlQuPkymlQESwoCWCp9USQdGhVQOP60xhyEfeyVXJ0VL314dXmZ/bgFAHCuqBnSnhMdNvetIzOd/488zY5dn849aGt9tIhD9ImOxp2mo9B8AWKY3J0sb7r6blSvopJgMXSN51zY44PGP0CeUmSWPj5a8M01sKmQ+6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aI6GJFX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB118C4CEC3;
	Tue, 29 Oct 2024 00:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730161244;
	bh=0RcBKxUNAnH20HyktGHycqKfexsnOgzeNXbbOuBOHYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI6GJFX7Ypmec3dZtauyLC9vsF5CzuipnXPS4MTeNEE1Ub3TJAy9Cbg+R64+DX2Mc
	 UbY5VHHD68P61jNr9lUVqEPmf8TriFdmTGT9wdWvh/5Nvpy0wK/+r1phfWnHTektyG
	 fRprXaeNipESzNmlYf3PB5mU4S7BBCZ8lvvO1EMU=
Date: Tue, 29 Oct 2024 01:20:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Edward Cree <ec429@cantab.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CREDITS: do the decent thing
Message-ID: <2024102903-unused-pelican-2852@gregkh>
References: <ff3fcde5-f8b3-4b20-36c5-68d73d0e4757@cantab.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3fcde5-f8b3-4b20-36c5-68d73d0e4757@cantab.net>

On Thu, Oct 24, 2024 at 11:24:49PM +0100, Edward Cree wrote:
> Acknowledge the past contributions of those whom the Linux project no
>  longer permits to be maintainers owing to sanctions against their
>  employers.

Odd whitespace formatting, can you fix that up if you wish to resend
this?

Overall, I have no objection to this, but normally CREDIT changes come
from the people who are being listed, so they can choose how they wish
to be listed.  Can you work with those developers to do that here as
well?

thanks,

greg k-h

