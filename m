Return-Path: <linux-kernel+bounces-557020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC517A5D288
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130207A9116
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5549265607;
	Tue, 11 Mar 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLKeIpbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319C2620C6;
	Tue, 11 Mar 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732130; cv=none; b=EAvecU8Ya2Q71WysSfEabexvrZo6J7umXlHjopbmvWNWw3P6w+NOiFsk6aPWsBrES7W4Lt1WkZUPevd0iHHtXpMD21CZKJa12cIt3M1AgBG5minB9aF0GLRc4KQRA4P4iGDasUiC1EgBe7q3UxCQTTEtjzFm5COl2/yIvzLBotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732130; c=relaxed/simple;
	bh=JYosVfXJ9HZ+hIIsL9NZHNAXWycCtZAVMG2NAMGdNMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmkrM2vcgThbcmU7/HLxegJdrdlafjpAknrvKY+bPSObfln3D5wKA66a2SD3nGvpostKqM80ma6AN+/akwPrQO+5qnm/spnwq6FS0eU8n42AsY7RtLsK0hqnaPPSMy6xEH1Tx2cYA1Hnfh6imlFG+sTbpSyPmC3v8Il1V2BW4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLKeIpbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBF2C4CEE9;
	Tue, 11 Mar 2025 22:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741732129;
	bh=JYosVfXJ9HZ+hIIsL9NZHNAXWycCtZAVMG2NAMGdNMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLKeIpbLHImvJrRSbwC7JoYZMLpc5MeMzADXNpSnRGwHDQHqMjhAwMn6ExJ7k1Szb
	 xdyP1KAxSbAAAEGyurYuCpFQgKbOaRKdMk19+YgN87BmU/QOS4l0yiGHBIFUG8+i26
	 cZrEeZbRgGdvL9d4GIfAxRNCk5uB7bwilwYMYjIa304CDanc5/zP5vCClSHiXI9oWy
	 TuvjgaXU+dVx1cAngLA3zwaA8T39BBmJ4aSI/yr8pWDbAnZgCdr6pn8bOwZToKJies
	 HLfr51/7H1TSGH7EQYez48S9xZqu37rjgljX+Z8ktzS9gVShtoWZDWA4ZjVkSoFsSP
	 GuVOUj+q0Wkrw==
Date: Tue, 11 Mar 2025 23:28:39 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Anindya Sundar Gayen <anindya.sg@samsung.com>
Cc: wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aswani.reddy@samsung.com
Subject: Re: [PATCH] i2c: i2c-exynos5: fixed a spelling error
Message-ID: <xyty5zgtvvbi56cgdl4k72dsjb37ksqrwiur2osfezmwnqmw7d@dzvmfwiaqsic>
References: <CGME20250228142018epcas5p463b70b48a1dd36016c26dcf66f8b489d@epcas5p4.samsung.com>
 <20250228133745.35053-1-anindya.sg@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228133745.35053-1-anindya.sg@samsung.com>

Hi Anindya,

On Fri, Feb 28, 2025 at 07:07:45PM +0530, Anindya Sundar Gayen wrote:
> Corrected a spelling mistake in the i2c-exynos5 driver to improve code
> readability. No functional changes were made.
> 
> Signed-off-by: Anindya Sundar Gayen <anindya.sg@samsung.com>

merged to i2c/i2c-host.

Thanks,
Andi

