Return-Path: <linux-kernel+bounces-365971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D094E99EEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9386D288B77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A71B218F;
	Tue, 15 Oct 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct85Jmwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D731FC7C2;
	Tue, 15 Oct 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001284; cv=none; b=pKitY8wOjjYLtfEY+3rsk7LRG+eDbdTycl2Nt9sKt+mCaTdBj6gJDHYcSuFF9FtqSR1DZhAyvhAkbpFA2t22OkH4y6uKCwKGwkKwn/RFARwJ7X4EqrqIC23urv6CwDVeItp91YZRawFNVtTCrvmBoj5pOu82qtz6/x/fNr7+OuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001284; c=relaxed/simple;
	bh=TgKCI/J+MpJioZY2jSL13GQYQj3n62HG0lvr9ZDUXqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGjmTrZe0p+TtaK7rPkQ/m1+2LNKTL7wwTpKuyjwhw3WabmMFKKZAJ8vTh8NPlesc30EpMxLx6q8EhCZbtG1+n45BrEQNQMo12vPIp42cAai/kOEOpQWAeFaIpZbCW4/eUtK8OZwL4d1Sy6EAAovKsfBzDnVMepTSyN6asrhFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct85Jmwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7FAC4CEC6;
	Tue, 15 Oct 2024 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729001283;
	bh=TgKCI/J+MpJioZY2jSL13GQYQj3n62HG0lvr9ZDUXqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ct85JmwjMBV3AJwUR7tw1ruafQzL+NQhzN6EHvRVKYPIXCmJvwi9D3H4ANbYwU5YF
	 l8fCQPcziKM/hiF4rOjYtZSvv2mTangM+Xxm4AE8N0/ejSQhWRFe5T/WubnOZeAoTb
	 rPsw9UouQuWQIiT98XNAw3P/iJ7jHNscE3vANs6DI3nINeplC49gIEBlKFo819ecIa
	 PHM3xm3kc+C5S9UGeBTMoVKBIDoyjXNSqKuOUF31frTj52w3DX6/6L0xA07GscJ7sX
	 qgwNkfHGyclczFEvO+hOHFR4JOpDb2saKKlSj9F0RnRqZzCW4eDvv+IH8kC96yrg+2
	 9eUc0XGJNPEOQ==
Date: Tue, 15 Oct 2024 16:08:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3 10/16] checkpatch: Remove links to outdated
 documentation
Message-ID: <Zw53QJ7PxDB1LwzP@localhost.localdomain>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
 <20241014-devel-anna-maria-b4-timers-flseep-v3-10-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-10-dc8b907cb62f@linutronix.de>

Le Mon, Oct 14, 2024 at 10:22:27AM +0200, Anna-Maria Behnsen a écrit :
> checkpatch.pl checks for several things related to sleep and delay
> functions. In all warnings the outdated documentation is referenced. Also
> in checkpatch kernel documentation the outdated documentation is
> referenced.
> 
> Replace the links to the outdated documentation with links to the function
> description.
> 
> Note: Update of the outdated checkpatch checks is done in a second step.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

