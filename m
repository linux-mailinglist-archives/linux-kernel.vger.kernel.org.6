Return-Path: <linux-kernel+bounces-549420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302BA5524F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEFB164BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1925A652;
	Thu,  6 Mar 2025 17:06:55 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4F2586EA;
	Thu,  6 Mar 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280814; cv=none; b=NxVDOMOWHb+KiOWSGGKScbgoB6xk5JPlfDaET9+cm3W+L4lehNZxLKjO/rLZayE/IIJ130iLL1IdOU0oWy/4p5W5ZlJN9VeSQIn2IXRD5pzkE96Ou6+0AklwXhOV+qO9SALMSbAO91sIt1752rAoKqF/eyQpwDAZVsLIWmlxj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280814; c=relaxed/simple;
	bh=jdlyxrR5UCa4Xjx11rzKU+gUoWtDUtEhY+tyBUhfk1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB9z+Bvk01BYCGDxFOU69f1y6H1Dyy9qK/Qr9nyOSVuIPvMecqBvB1c+YJI4aJfDOektzRFgSeP7Lcn8rS+CbWTmPTEqH6DoIDn5iIPXT9C0c+tITsHqTozduzTzHuKqy1OoxBJ+NWSqn1RGUTyOTk2GPcoPuX2SOnSZb5WL/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 526H6Wlq025810;
	Thu, 6 Mar 2025 18:06:32 +0100
Date: Thu, 6 Mar 2025 18:06:32 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tools/nolibc: mark more test functions as static
Message-ID: <20250306170631.GB23569@1wt.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
 <20250304075846.66563-5-louis@kragniz.eu>
 <61636d83-8154-4e7b-850b-1c4ed9a2c2f2@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61636d83-8154-4e7b-850b-1c4ed9a2c2f2@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Mar 06, 2025 at 06:00:17PM +0100, Thomas Weißschuh wrote:
> On 2025-03-04 07:58:19+0000, Louis Taylor wrote:
> > It was mentioned that a new test_ function should be static, so go back
> > over existing functions and mark those static as well.
> 
> Actually Willy wants these non-static for debugging purposes.
> I can't seem to get that into my head -.-
> Let's drop this one.

I don't remember but it was probably to be able to break into them with
gdb and/or to check the disassembled code when in doubt about anything.

Willy

