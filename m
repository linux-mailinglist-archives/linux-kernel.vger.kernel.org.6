Return-Path: <linux-kernel+bounces-544263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16480A4DF75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1817A1787BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A282046A5;
	Tue,  4 Mar 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KM1SBkNo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B920468B;
	Tue,  4 Mar 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095646; cv=none; b=pbWJmfQuo+6L+EeC8m3Rbr+MKunwUIpnvksyDIO2KUvZAGS6frYxkrhnC4IDJ7Ugm3nSxqWLyx+oL3kETXdNyFEFe/UTWp2pCA/kLKqxj5FhIJJsgNCrYigo4kjfrs7QrCR3b0995ethIzdkg64pWj2VTwWUNW9bRkC2FQ88VRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095646; c=relaxed/simple;
	bh=/q3UZng3cxiaVz25L1zBGFJF+ggJwCQeaskTtultPkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH9je4U6Ex9KVNiPaB1jazNV6s4IplRGmY0loj4g41TmwwtYQ6/NwUJGufn+MRCC0L3fFOQdWL4WUPGmoJ19LbquBBP34FW7wippyxExdVWDy4Yuab8YzvbGATC9ben5CchXokl8+P3x1HqhP939Bq+GQLsS0dFIPsj3bOu6JKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KM1SBkNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7127EC4CEE5;
	Tue,  4 Mar 2025 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741095645;
	bh=/q3UZng3cxiaVz25L1zBGFJF+ggJwCQeaskTtultPkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KM1SBkNoyNpm4nd0FpOhmVc3gGzeppTy6pAs+2CFoc0e/p56uC8hhgGZudjH4eK9b
	 FUOgjHzUZTybEVdhEUTrJjUFsJbjowVc0ZrZRlDSzFu6NZCFDRM3J5Zfj9K3kg+eHS
	 3KyjOwRDKcGujGVZCMem7UNGGSsgjWJ6uVW2cHjU=
Date: Tue, 4 Mar 2025 14:40:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: raoxu <raoxu@uniontech.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com,
	zhanjun@uniontech.com
Subject: Re: [PATCH V2] usb: xhci: Add debugfs support for xHCI port bandwidth
Message-ID: <2025030411-aviation-steadfast-b4de@gregkh>
References: <20250304070914.3991-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304070914.3991-1-raoxu@uniontech.com>

On Tue, Mar 04, 2025 at 03:09:14PM +0800, raoxu wrote:
> On 2025/3/3 18:36, greg k-h wrote:
> 
> >
> >The subject line is very odd, can you please fix that up and resend a v2
> >patch?
> >
> 
> I have sent v2 patch, No code changes were made, only the subject was changed.

Then you need to document that below the --- line as the link my bot
sent you described.

thansk,

greg k-h

