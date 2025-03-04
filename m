Return-Path: <linux-kernel+bounces-544360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54199A4E05C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE7166AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B7204C1C;
	Tue,  4 Mar 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7DmCjQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE02046BF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097455; cv=none; b=QxE6uWx43EfPIjMNHmaNluMsAsS1tIQ8LnwDTG/ziVCmErq7epa82mIZ7l/+/duNaEp2bDi0yC3Myz4f03qjjyXeWeXZLk7+bMdD/F2vhlPmeYSaF0urdrWZCTnMLdzIIFjtDb02mg4FII1k5qgg1x/HYzjtsOwJ24+7ByyuvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097455; c=relaxed/simple;
	bh=vlgdB+WzamWmbFk4zbIdChULSRzD+xZctrqqiI4QoW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxET4H476TmamOmxo96v8oT5LA/Kzi4nUqMOplydXVdLv/rxp6ZYXzHFG67D7M0OzNQZuzw+/QpRVJg9QLDg42G1uXf8boWWqQFQ7tDDssM3DXcDuaaPHqP2HNd6/vyRyS9CJIcgnb+5S9zp+TwH5mxa2OgKR1SZD8m6pFgoXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7DmCjQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B0EC4CEE5;
	Tue,  4 Mar 2025 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741097454;
	bh=vlgdB+WzamWmbFk4zbIdChULSRzD+xZctrqqiI4QoW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7DmCjQSfbw5n+QaOjvYv4ns+9T7hkfGrX0VOm9vYnW/kwSw+9veEZoAm9FJ1E5Rp
	 KkSWJJhky+8KNR+KsLX4BZGgt0lDwjxTEXkkfW808yZcGfPDVbRhqrgCtCokHfFN76
	 ieso4SnSk4Ui4+R1ZXNCpntkDuAwjngow4myOqyI=
Date: Tue, 4 Mar 2025 15:10:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zxyan Zhu <zxyan20@163.com>
Cc: broonie@kernel.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: debugfs: Fix name collision without atomic
 operations
Message-ID: <2025030418-pucker-flypaper-abac@gregkh>
References: <20250304122221.3317232-1-zxyan20@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304122221.3317232-1-zxyan20@163.com>

On Tue, Mar 04, 2025 at 08:22:21PM +0800, Zxyan Zhu wrote:
> A global variable caused debugfs name conflicts during re-entry,

What global variable?

> leading to creation failures. Use atomic operations to ensure safe
> and unique naming.

Naming of what, the variables or the debugfs file?

confused,

greg k-h

