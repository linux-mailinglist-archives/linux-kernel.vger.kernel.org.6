Return-Path: <linux-kernel+bounces-525359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EEA3EF00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5167A189D8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42B20103F;
	Fri, 21 Feb 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK0yXHMm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21F1E990A;
	Fri, 21 Feb 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127594; cv=none; b=tWjHdWk/3fJOqFzkW7uTaPwV7EaPKWp6/DCsAw7myQuKgZiAKuNJU0zXV5hePJLwyuU8E2tXrnTGzqCTRdPLKBBx1sxYxMQDF7B6Gokm6r4LX20wfSbn+5QiN6ubrwpbl0CbXrWVnxoCxeVmagZfn171CYVbhg27QnP9FMGjaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127594; c=relaxed/simple;
	bh=/7ch4XQAX4vODZjmYMOM7L1Ju/T7AgMW7U8g3mm6OiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVnPwJSyGCaUDyN1MjTeOTT0NgO4o/PmRTdUVirisXqkNZeTFypufTMPsle/lu6VYi56jdB7I2lW9lrrQp+Y2NlXqkH0iOA0pIraHXEFc1RbNN0wLj2/K7V8aaoabroFNhytEdeDHbyNKWyqGyZ0LZCRdX6nb5BW7cTz6OEqsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK0yXHMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3DAC4CED6;
	Fri, 21 Feb 2025 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127594;
	bh=/7ch4XQAX4vODZjmYMOM7L1Ju/T7AgMW7U8g3mm6OiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hK0yXHMmfZT9Ot35prS7Izdgu40ivvH/I+Z8zPAoiM//uhBxnlTtnCmHPKZjC1O8j
	 Eq+poiJXdQzCH3iv8H3DGcIxTKdn3h+mzGUgWY3PnwBtR2RvYFspZ8h+6c9a6vs3g9
	 hH0Xeg2ZCC1HrXAo/tM+dlG5RNAWsRcJLAzpf6af/b3y9gtvYv0IHlSqiFWazcQHtg
	 MBKb3udv4h0MMKL7Rd2HLs03TKpOOBzTfOWgST4yHFf0UAWiuzDauJWO/6l+w0NjpD
	 qyyMHZQsufHVJdDCb0I4lZEnoL7E0+CFvjH4A+JYj8nJuDB8Vw9pUZNqyxvdw62tB0
	 +v6VM+TbSj93g==
Date: Fri, 21 Feb 2025 09:46:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, salee@marvell.com, gakula@marvell.com
Subject: Re: [PATCH v2 2/4] dt-bindings: cp110: Document the reset controller
Message-ID: <20250221-huge-able-ostrich-5c70cd@krzk-bin>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-3-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220232527.882888-3-dingwei@marvell.com>

On Thu, Feb 20, 2025 at 03:25:25PM -0800, Wilson Ding wrote:
> Add reset-controller sub-node into the system controller node, and
> document the supported reset lines.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  .../arm/marvell/cp110-system-controller.txt   | 43 +++++++++++++++++++

NAK.

You already got feedback that TXT bindings are not accepted.

Best regards,
Krzysztof


