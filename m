Return-Path: <linux-kernel+bounces-227356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FA914FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8CE1F23114
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA118EFC8;
	Mon, 24 Jun 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2HtnoW+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10618E757
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239493; cv=none; b=CWOjKQxdzU+//uDE4rMMHyjSHLqcidKJdeUlsZ+rKZ9/sLwf7gPx4tTVh81xYtpNVmq34IUy3+RPzjMp1RiPSFWRHz5GBBDsmNRkvN9rS2AmVvmfeGbt6VPuX/UUL7+wIdhLVXJ6nMmZk/HBFKfml6+lDs88uZLVl+dbjLz+mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239493; c=relaxed/simple;
	bh=hAfezHP22ihksSgLvJdqYyltAdUe4yzd71njiy4KTq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhCXyg4dXTjtpZ8LPeVj8qZhf55ek1mT/AmEHNNaMNHhND1mZA/yXfqbxgRfcn9WQQVqGJ3zmdUJP3WTOALWehekd+SgvOwDHg1p103bcsZtO7qCdyyGq2LNKdZxT/mlEtugEyXcn+uzhRxZdpovPFBzwMmlN2M5vUeljl69TGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2HtnoW+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E117CC2BBFC;
	Mon, 24 Jun 2024 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719239493;
	bh=hAfezHP22ihksSgLvJdqYyltAdUe4yzd71njiy4KTq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2HtnoW+PRS17vBy4pE3CH8MPqs+w1Vo3jfpZw5ksZuoP0hxrLWfNtN9v/n45Bvp9p
	 WkgHSkZtc47h61S0r+N+loke8lslGVAzhFEMTpNRXsg9frtNV98oBRkd2rbAAs8Mb6
	 Etieh7E1W7Ar0dk6JMLc2bewk/avcQCucR2y6AJk=
Date: Mon, 24 Jun 2024 16:31:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentong Wu <wentong.wu@intel.com>
Cc: sakari.ailus@linux.intel.com, tomas.winkler@intel.com,
	linux-kernel@vger.kernel.org, Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v3 5/5] mei: vsc: Fix spelling error
Message-ID: <2024062415-system-stuck-6836@gregkh>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
 <20240624132849.4174494-6-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624132849.4174494-6-wentong.wu@intel.com>

On Mon, Jun 24, 2024 at 09:28:49PM +0800, Wentong Wu wrote:
> Fix a spelling error in a comment.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")

comment spelling fixes do not deserve a "Fixes:" tag, sorry.


