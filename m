Return-Path: <linux-kernel+bounces-517883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C4A386FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2CB18984AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3662236FE;
	Mon, 17 Feb 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LdMNlwDC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S2jI3v4/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86F21CA0E;
	Mon, 17 Feb 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803861; cv=none; b=jlZjUOqo7a1qUOtkhEI5Vm6vFJ67WkiHeM4kVDIj2F8TqRbLp8S2WceSleKOzSmn6EnA449/ns9DYegMrVMDtbvIVwDmBXPeYyy9JGcppveuBFOlHMFJjk/Fnyk/0MzoZo3Rh9Ts5Fkl3ILWzPP+tnVkasqheysXY1vEudkCW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803861; c=relaxed/simple;
	bh=WjK0AaiOGZPzD6WPGTZNB2MYaDX79CF3ES9/OHZUn+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijKNSXaXyw3Kgs7f9qzs+8KhWXmguWvgWF8/nMubE60GQI3DP5CrO78CE/A32hIVlloB8WvfXRDcLep2MuKxM7UGWHh/G9tQutS0x8CLDdFsMSlDAQVlOQHmJGZStN7BtoxgbTcDsKfSrQQKk1kAx3jEUCSRcyrFNjN3usCGtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LdMNlwDC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S2jI3v4/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 15:50:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739803857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2sPfQZeay/1JXMe5RGbQaAOhB59g6LOSfQU+7lUlqI=;
	b=LdMNlwDC5lDIT/Jpq8cLWTPbvimW/JscZDQRx4CxlRBjyO/RfxVBHBovmcfvwei48Zi1n4
	Cki8D6+FtvFxa/l2hwUfJIeiW9Fh2wh2RP4Ah3o6l7kopWo0ckWjdk6SVWIxIUJ6HCoWec
	s5l693cp41fYWV4fI/PLXR6TB+h4qOtcNHBke+frCLq1zfwihx3sUbECsKI6AGfMQ30o2V
	V+lccjqrKjEX3cdPDFWlRv2Wi4eJNIbfJrKDUmls/OiSqt58ETNVf68E8trM88QMtzn250
	PRaw0wJCra+Ud+xcquDBmLSyBnbCqWIZKQJKZ4pz0l0yEADzlphijA+ZCJAv5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739803857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2sPfQZeay/1JXMe5RGbQaAOhB59g6LOSfQU+7lUlqI=;
	b=S2jI3v4/Olq9v83ieKDobcjhEdUL3f81KbO/RhkmrGvI44BHA4HRqSEHES+BQP4DOv0T87
	AKFQxN+/p89+35Bg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: core: Don't use %pK through printk
Message-ID: <20250217153444-4e1fd8ec-7f0e-4f40-8fc1-e323e4622284@linutronix.de>
References: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
 <20250217-restricted-pointers-usb-v1-1-78da55158832@linutronix.de>
 <2025021733-strudel-curator-bfaf@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025021733-strudel-curator-bfaf@gregkh>

On Mon, Feb 17, 2025 at 02:52:05PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 17, 2025 at 02:20:51PM +0100, Thomas Weiﬂschuh wrote:
> > Restricted pointers ("%pK") are not meant to be used through printk().
> > It can unintentionally expose security sensitive, raw pointer values.
> > 
> > Use regular pointer formatting instead.
> > 
> > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> So really this is just a revert of 2f964780c03b ("USB: core: replace %p
> with %pK"), right?

In this case, yes.

> Why not express it that way, and explain _why_ it's somehow now ok to
> use %p when previously it wasn't?

The full background is in the email linked from the commit message.
%p is more secure than %pK since
commit ad67b74d2469 ("printk: hash addresses printed with %p").
%pK was never intended to be used through printk() in the first place.

I'm doing the these changes for various subsystems using a common
commit message. The changes are not reverts for all of them and
digging out the specific history for each single line is a bunch
of extra work.
If you want more historical context, I'll resend the series, though.


Thomas

