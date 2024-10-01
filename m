Return-Path: <linux-kernel+bounces-346676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA298C770
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3B1F24D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6514B1CDA31;
	Tue,  1 Oct 2024 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP/YjE+A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1813DDB8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817368; cv=none; b=mEZE5IsbnkAr21RBrUX+w6g4YujSxFfiSMqyBVm0eVy1JuJt2p7VAoVPrBbY3itYOovMH0xMq0JgPoiuH2r0btvt3UvVUV6TwmC4pc28+RcYfbeCA6ciGJwfGXX2udq6pCTN7fNRGYEEcSzqHBsv1Pa/gdIItsB5Jr/FXtJKLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817368; c=relaxed/simple;
	bh=tUKPru65IHswJ3g+H3HA0RO5vT1h8JoPwQJlcY6LAIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH0NSTy6DpVLNJ2nSfyOdrNGQnS7vVmEkP/KRv2XTIOZE1IKpKPDQtVS4kY1p8nxqEMNc6zlK4shZtUNorhodBvB9MO6RCCMAQeElpEKyI8buieWMGlfPDKx6x+l5Yr6KxR3Px7zBtEJGAEANe+UfcJ4TmoUiHN1HkiCd8+WQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP/YjE+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D75C4CEC6;
	Tue,  1 Oct 2024 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727817368;
	bh=tUKPru65IHswJ3g+H3HA0RO5vT1h8JoPwQJlcY6LAIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bP/YjE+AH2XwHGt7iwxRecqjO3Y4zxsbu2YmpVujzPZlHncPS7KSlb3s/6aZDfReE
	 8mfL43yuQf7teWBhYDpzanPoO+CJTiULn60sS5R3gMaOFgba7KiNMxyCLdXpHCDkOJ
	 GFHxeSxb7NzXCVoRnWorOg72e9YWECjYi8JgoI5OBbKo2PWBWKfeTe9oS9j1/blRbT
	 zZVZGjYV9SPaJyGZsiJ8gzDXONniKv4LUAaJ06ukRLufmaGQJrPQX7CX4rWx401BCP
	 3QpcMMJEvYPf9pqPxQfZpmMjwFhvftgu18rBUXG/YgM/tirdVfMbmGSuhlhdZRsEuL
	 SPtjpb4MJXT2g==
Date: Tue, 1 Oct 2024 23:16:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 03/15] timers: Update schedule_[hr]timeout*() related
 function descriptions
Message-ID: <ZvxmleWv9805yxe_@pavilion.home>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-3-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-3-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:29AM +0200, Anna-Maria Behnsen a écrit :
> schedule_timeout*() functions do not have proper kernel-doc formatted
> function descriptions. schedule_hrtimeout() and schedule_hrtimeout_range()
> have a almost identical description.
> 
> Add missing function descriptions. Remove copy of function description and
> add a pointer to the existing description instead.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

