Return-Path: <linux-kernel+bounces-532771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8FFA45201
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105873AC35A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC061547E7;
	Wed, 26 Feb 2025 01:11:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0F42A9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532311; cv=none; b=GRXp8RNC7c9fa85iHwrPfKkhc/YJ6dsuuK0YjA9QmOW/pzPY/nhoMmUM1MAjp68A8Bt3wbplI2oXRewPmOc2gdsG+94UKbpCvqJTNyzk1XtNZTaozvO+Zj/mtROfSR+jBirSLNIE/2mlZO/b/EC5XsmfyNDTdyRphj8HQwE4tZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532311; c=relaxed/simple;
	bh=2CWPUyylzodqWRB+PA7AJR0/W4H7RjJjboZLYHQyexE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9dIbptegFU5+kq9MIzBFwgo4B+PQiKmhkGtnK1ObXA2IXcQqKsbXZsC14qGO1Kq/ByIk1G2M5xIJ6SaUaHfqwEqdz943/LNKzVFeIE2RaUyFnA+6/Iaw5MUTRiVkxi56Z+avIDFJ9Yt/P/rra3aEvYpSL/XlHCpTSvjcmSFROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DFEC68AFE; Wed, 26 Feb 2025 02:11:44 +0100 (CET)
Date: Wed, 26 Feb 2025 02:11:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Converge on using secs_to_jiffies() part two
Message-ID: <20250226011142.GA27339@lst.de>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffies() that

It's not a series.  It's a set of not interdependent cross-subsystem
patches that you post as a series, thus causing tons of traffic for
no reason, and requires me to manually approve mailing list posts
every time, including for each reply.

Please just send the patches you need to resend individually next time.


