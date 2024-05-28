Return-Path: <linux-kernel+bounces-192795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701848D222F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09F91C22854
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44509175545;
	Tue, 28 May 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZszT1Oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F438173339;
	Tue, 28 May 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916207; cv=none; b=ezN2E4EIo0OqxRj4BHDLBzxycbEzxH2EhrdvzIMtz4jNVlWnaTFf5TYA2kec1DogowDW4J5GcGO5aFoWGeCceEYvfTThPtJfWOYf24Wwxbky9WeontrWNbb4J6m09YzUTKM3ULupz9aXaZKrvRZ8SJWGGv6BiOEuelfGhto+BJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916207; c=relaxed/simple;
	bh=B3E/QGp7FngdO9p2TYdzPNibioEyg6tO73saBRqMObQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmMtXD2fnEkn3bMQ3jROpr7ooWb6Hhp2dp0uqAPBwczCJiDYwf4hXavSNTgY3UGCOIXk+Imaah+d6Mn5ocm08dVj8XD2IOjhy/QbjJXzACNkbFLtLSiLSOiSx8+4fN4BvpU8XYjNWL8BxkT7RK5WOq2T3UJsAX4JXM3mKmgV1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZszT1Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1F9C3277B;
	Tue, 28 May 2024 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916207;
	bh=B3E/QGp7FngdO9p2TYdzPNibioEyg6tO73saBRqMObQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZszT1Oqv0rSz3TCQkigMNv88tsjNRt8vwCYNLz8Ze9Sqm1JP6bcGHs/eWE6yMbQF
	 QE1IjMRfNOanoudkJx3mtsFT7tcsMZVgPhidmjWmMUIhNEiQilfD5M0twZqbMUzB9k
	 E9Iim+56ZXUt3EyQwEGFVFw2VM4PTjWxQfcvRgI7c1uXXQ7uRxpBhcjpW5Jki/ejRo
	 IfLeOyZp/7apcCEqOOzzMC5BXqn/Oyp30XEU6HQ1vAasgBs6FXqKkAd2I/7MLOQloL
	 Y3G0xcU0HVKiCC/6xytApk5SsoMvwKWgER7T9esYCxM//vstN4voACukuTh7Ij8gMG
	 3NMnFuU6ulMAQ==
Date: Tue, 28 May 2024 12:10:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] of: of_test: add MODULE_DESCRIPTION()
Message-ID: <171691620162.977890.15152918673691934863.robh@kernel.org>
References: <20240524-md-of-of_test-v1-1-6ebd078d620f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-md-of-of_test-v1-1-6ebd078d620f@quicinc.com>


On Fri, 24 May 2024 16:58:26 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/of/of_test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/of/of_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


