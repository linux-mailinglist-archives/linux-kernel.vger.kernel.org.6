Return-Path: <linux-kernel+bounces-568486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C54A6962B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF731885B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB861DED5B;
	Wed, 19 Mar 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nUHtGHZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9451DE4FB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404533; cv=none; b=i0HICARr5xZyxMpDpyuU4T9M1ernHu+6eqLewJtcUSiWxqe2pg2y41xvxzMiYED5g4T9BENViKeMBxe55Zl8bSEax0ChWeNoQ7TP/TLY+ogKC1gvpsIYZg3kCTEUEMmxhcVbqDVEAsFKWRmP9AZB+arIwnjxzMI0bdFbXEf5Yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404533; c=relaxed/simple;
	bh=JCUCI+alsBXx2M7Grq1l30pkPDSBdtdGqLOeDBd0iLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNeF64PEJcBzSXva2VmprPffdM7DfmFBgqEfdDPC4SH6vxtS0GJFUpijuKDx9i8VDnWT1wgsL0pa7ik8kmTUdisIcjFIU4WkrrdprmtLhj4LfQjJvCQPjD6xhSFD2c4At2zvsEiBLgkaR6YvxtlrhjMNs4pmqEr5Iwskt3YMBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nUHtGHZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F35C4CEE9;
	Wed, 19 Mar 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nUHtGHZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742404530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XAGWpMtv06FN/qqfbGvNv6CZbbElV9I5LBm9di6JsLc=;
	b=nUHtGHZQabpEsRfHGYmACZ+Y1KzcuLZBOOVoezHhNUifBPozeZQW4lKTSVGvK05fSNJAHx
	ZFMcRp8OtkPw3890XOstyFHnoBkqnXxOaTYMxVlkrl/bLOQxZIPbB7gmphlYxZ/rhWpHU9
	Tb9awc1/+ROf3MZ03Ci3HuYVnYON6To=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 11230d79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 17:15:30 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:15:26 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: Add missing words in function comments
Message-ID: <Z9r7rq56uPz-vI7D@zx2c4.com>
References: <20250219210031.28963-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219210031.28963-2-thorsten.blum@linux.dev>

On Wed, Feb 19, 2025 at 10:00:31PM +0100, Thorsten Blum wrote:
> s/good as/as good as/
 
Applied, thanks.

