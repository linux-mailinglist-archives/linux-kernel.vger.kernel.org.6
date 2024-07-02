Return-Path: <linux-kernel+bounces-237790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD86923E24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1778AB22295
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3815EFA1;
	Tue,  2 Jul 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz2ChsFv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F415533B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924712; cv=none; b=UtxwFtaiU1RPjSFSWVF7vAmQ+1p/idnIlXbjYYCPuxumhtD2/PGTW+gjek1cakc3k+y6/Vy39VEdyyZu9HPSU0SccgxG6TAqqRWQGT3vprz8Cgs8b8gtR3g1gqFKy6O4Vjpd7Oz1IqwHY+G8NFxK8gXGEBFnwJQKGeOXCKXKhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924712; c=relaxed/simple;
	bh=d3X0+UNyOQe+MqWWcGO1aGSt+UoXd3or/k3s8wSD5Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RreIy9yNpw4RnLkvcTtXyZuQLVPhtoevcJwk/UWjgujsJ2IGNs3biZFEdMwZrdmTR9z1ERj2kjiUwSwwz1LPmR1ERRNJf5Bpdfl4VMGSHcFpxj1Tq7aNYPkYC9W9zhzgG9HUDDZlGLfXf0FkFZbmdtWV4jWrShsFfF3B7vEi9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz2ChsFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D44C116B1;
	Tue,  2 Jul 2024 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719924711;
	bh=d3X0+UNyOQe+MqWWcGO1aGSt+UoXd3or/k3s8wSD5Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nz2ChsFv/Vo76miFuAyZfhq7OYty0OBXUrFfOXryMWxrE9EEc6TZqmNGfQ84xtlZv
	 1J8uqMS0cG0CBpnwG6v8A9zh+kw2LEu/fD1/sLdRxTRcRmu747VpcA56ANalas53nA
	 W/qEPrpNY4x2rPOlcFoDXGHY9P/TNFu6q3sW0QgpMOZOt5qlhqgwdbUYZO+KY/ukL1
	 aREfTeTleBmbhePgf+aYq/RMk2473oticXaggxD1bx0qWTVR88CZHHkhXHhKJvDlfM
	 JwXlmQpi+tXVUiehxlXxi66mW6o3gtbnL4+wBvtM1I4azVgIZHzvz11kOjUsvDwPoC
	 HDNLYo89qhTNQ==
Date: Tue, 2 Jul 2024 14:51:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] timers/migration: Fix grammar in comment
Message-ID: <ZoP35TUQwB-kKlJn@localhost.localdomain>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
 <20240701-tmigr-fixes-v3-8-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-tmigr-fixes-v3-8-25cd5de318fb@linutronix.de>

Le Mon, Jul 01, 2024 at 12:18:44PM +0200, Anna-Maria Behnsen a écrit :
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

