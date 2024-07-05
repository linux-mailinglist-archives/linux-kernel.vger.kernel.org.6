Return-Path: <linux-kernel+bounces-242388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60192876E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DDA1F28216
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37B149DE4;
	Fri,  5 Jul 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snts7QGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045E149C59;
	Fri,  5 Jul 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177293; cv=none; b=Xbg4U+7qgybG+9JMxYcwTQKsLeJvUOkOmMj+9Oq21QZn1FX1PKbJ5jE2Nxbb4fWolrF1lQ0JFewLtjuYmKnMEfxz/psNK6fl9YernafN8wS8b3v3mAFeQVR4lzbLC2z147ZbZVjWwiHDsCJ2sftdLIM1ceyu2uRO5jZTqGvllpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177293; c=relaxed/simple;
	bh=EhVybWgGeHW8VqFy+izcO3+7vqNtnv4UC1PQgr1iIpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJd6HdKxDr6JE2Zjm3yiRVLkwizbh51f60XYBAWhOv+kSHbC/vWzPS4cKwo6ry++oGhfcX5mB2ewFb7hORy2g+oxYGrVfRWeKXbPYKS0W44NO8x9puEWWys8qkkEpSLgPU8M6UMranXMGanbrhsAGfPBi8kgPoCBra4Cs8bF5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snts7QGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E806DC116B1;
	Fri,  5 Jul 2024 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720177292;
	bh=EhVybWgGeHW8VqFy+izcO3+7vqNtnv4UC1PQgr1iIpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Snts7QGuZAPwkv83dy0VrmrGWCBdEnQpAtgyF+iWkpzmQm/ckgJSMaesuhQRvRFrl
	 tS+5jD25dvg0dqE90Fg9ZOrTfMfMzpeRrGPKYKuaZRC0jbz09gQw9FZDmfQs/eXD4b
	 SVILwn3zjg/rKb4j6akHxS+o3OFJkWqhz+msPc/nVkvAORq/HPHz3TviAFNOIdgVYB
	 DQqY5HIjGWkVgllF7Du3FQ7Vc/cwEJlWOkIUhAczU8nmt1p9vLocC1zDnh735FfCmj
	 1Oqm+9qul8vMWihNViyYgVg1rpQXMopqYASBxw8Us5bInxMnuF36CHG6EkdkTiheda
	 OZWzYw8jx5+Uw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sPgh5-000000002UP-38FG;
	Fri, 05 Jul 2024 13:01:35 +0200
Date: Fri, 5 Jul 2024 13:01:35 +0200
From: Johan Hovold <johan@kernel.org>
To: linux@treblig.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: spcp8x5: remove unused struct
 'spcp8x5_usb_ctrl_arg'
Message-ID: <ZofSj98X-uEr-Awj@hovoldconsulting.com>
References: <20240529234722.130609-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529234722.130609-1-linux@treblig.org>

On Thu, May 30, 2024 at 12:47:22AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'spcp8x5_usb_ctrl_arg' has been unused since the original
> commit 619a6f1d1423 ("USB: add usb-serial spcp8x5 driver").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Now applied, thanks.

Johan

