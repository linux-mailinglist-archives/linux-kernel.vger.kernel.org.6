Return-Path: <linux-kernel+bounces-343770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FCE989F39
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0695F281CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42D18132A;
	Mon, 30 Sep 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dns5G9gK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F217BB11
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691379; cv=none; b=e0fOaoL3lVBBVJLMwXnEHroyJKvP2KOCqkjonQQjO5kVIcfe+zUBRbKKqfPR8EnLxcjw6MgFGp321ubKE8E9hVQ9Qdr7Et8VSZHnh49C/Gm4AXSxykV1jvHDkz2IB0Hf67lI20Tw5sDYun77vHMEPw0lV5J/i7rZRrB87H8LZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691379; c=relaxed/simple;
	bh=V6xD5Dthr2G5hBJWw3hACCcSukTa4OlV1MBywXuCwOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndb/wSMzF2xT2BIXA4HlEHy1GLfNMMT83z7d5jxDoMVslXJpqv1nI/F2aXKJpC73Vd5vgOd0o5gn4Z61qJhSDTJDMjYU3MtzMJVhpLxoo2YLn9/e6opmMkFU26FHeGAGKg2RqJnjINXpsKGtYgOjkKypq8QTTqzvCLiFfrmgvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dns5G9gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC920C4CEC7;
	Mon, 30 Sep 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727691378;
	bh=V6xD5Dthr2G5hBJWw3hACCcSukTa4OlV1MBywXuCwOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dns5G9gKdV1cdGZjJ6f/kpDcUG+BxrfT8F7jkUy21e8Z8oUkMP/uAUOZElfn8kB1c
	 GIjmKFVfNUm0RZdBCtcdSuahGHhLk5t3A5nqvdvQra5KS0ZT/iBmyY9xnlQKQoQale
	 vOfDwi4lXJMhiXZtLOqOQAYLIJNyZrnQcVMLkzZ0=
Date: Mon, 30 Sep 2024 12:16:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: change mei driver maintainer
Message-ID: <2024093048-outwit-stainless-a2a7@gregkh>
References: <20240930090604.1788402-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930090604.1788402-1-tomas.winkler@intel.com>

On Mon, Sep 30, 2024 at 12:06:04PM +0300, Tomas Winkler wrote:
> Change maintainer of mei driver to Alexander Usyskin
> 
> Cc: Alexander Usyskin <alexander.usyskin@intel.com>

For obvious reasons I need an Ack from Alexander before taking something
that assigns work to them :)

thanks,

greg k-h

