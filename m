Return-Path: <linux-kernel+bounces-356740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0C996608
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B0A288BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDA18F2DA;
	Wed,  9 Oct 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pzB/7JFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CE18EFD4;
	Wed,  9 Oct 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467596; cv=none; b=n5AKUre1t6lLMZaMrzapSyfe85l8Uy/9yx8H7UUFiSOPwCdhcq55s77P5Hq3qh95inUhpnNgWBTbOF+lOye/D4raSfrs9gwCyGmFneGNCjbUyPSm2Sp4fxQunnQDg9lsrv/RF8Fy5ilMFwlAs4PiIpWE77Kn+ORpGANuBZjtJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467596; c=relaxed/simple;
	bh=j2Lxse2BN4aTLr8ZejBZA1i5O2pOcx+kLD6jz6YZ7oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4I+jyjm5F4zUc/oHdQe3ZlBgIC3jo9mkVT1+Df7VDLge+tq71+iT9ekY34ExoodpaLEViB6fBEuMHQUrQLEynHHj2WUbGYtwYGseD6/CiiW4ICdHc5VOsndumqHPv60Amm1wWpCVK6ThLV71E9Mf/3sqxiqna56HCogTOhDLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pzB/7JFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DE6C4CED5;
	Wed,  9 Oct 2024 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728467596;
	bh=j2Lxse2BN4aTLr8ZejBZA1i5O2pOcx+kLD6jz6YZ7oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzB/7JFtuMXRV9Tgp7v0B8g5CtLCObkdiOMCeTSSzolPY3iqAattoMtPJCJurk3Xc
	 nDvvZm0z0PUM4zcBMEqg/UqgOWdBsd6OaJy/7nUNmxhgNFlQipb8Z2tQsbqyyLkgx7
	 RCXi/U+hvEcJf8/7mFoDGDcZkZUmR1QcH0ciuBn0=
Date: Wed, 9 Oct 2024 11:53:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] Staging: rtl8192e: 18 more Style guide variable
 renames
Message-ID: <2024100902-jurist-outward-a6a4@gregkh>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>

On Mon, Sep 16, 2024 at 10:31:34PM -0700, Tree Davies wrote:
> This series fixes camelCase variable names
> Thank you to all reviewers.
> ~Tree

Sorry, but this driver is now deleted from the tree.

greg k-h

