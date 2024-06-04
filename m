Return-Path: <linux-kernel+bounces-200734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0E8FB435
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E41B29B56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE3148836;
	Tue,  4 Jun 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zWqr95Fq"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B96144D23;
	Tue,  4 Jun 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508593; cv=none; b=uRVGuK2CbxrDaZ92qit11nUfr6EZpfEi/SF+Z6YqTw8wVXh6bEtnYC9e+vvXZRe86Qg4hzQnHRRXFynhksx8Gn1c+XVmF3SOChm4uwfmvMT23u1ngTAmyrN48NpRx91I3yToZN4tkviTxEIApdPwbTmpgDive9WozCCUuZ8qJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508593; c=relaxed/simple;
	bh=s9rg0xKazwih6oPuOEuE5wEC2gCvQpXYl5XV3pLTn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4qKNcLaX3qjYv1r6xwReEoWrcvmirTA6x88XitHBkKSzBHhRLd4B69PNskdvNMXSSHsrMxfqgkuo2m3bhwtr38plFsm6+8n+OGl4lrRCEwZp/pPcDLjPnExtnDaBMAPwWbxPDCWXvNQUmb7+FHUtk8mSosOjxY3Gtb5iBp8VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zWqr95Fq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id EA4621F83F;
	Tue,  4 Jun 2024 15:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717508037;
	bh=s9rg0xKazwih6oPuOEuE5wEC2gCvQpXYl5XV3pLTn10=; h=From:To:Subject;
	b=zWqr95FqqexgpAKBfIEbwsvL9BcndvX51R6PH5soxwwTR/DP7bQwoXIEU6rDLjqDw
	 ghbIC7PWxlEja3Rxg2OTpuceYhtoV4feOzkLhQF1EgqIITCkDI4l5Oj3AuPoxVZUOh
	 P5u86GU5Y5fzQHk54FrJrWXxJZVni9C2/i9Inmdv8qNKDS3TG4sl4yFGsf+n/FL8Z0
	 dyAKBiFkuCYMjxOHPTt0GJkLu0VQgirm3NVy9/SGwXUuqQU77uMmn1K8KMsmn3w18Y
	 F7+fdD8CDapN+cA09BsWVXgfr/pO0le5tkTAbRPb4RWpbSh0QuzWHYm9YtvfDVooYk
	 XWkYqaO0UgNpg==
Date: Tue, 4 Jun 2024 15:33:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jai Luthra <j-luthra@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>, Bryan Brattlof <bb@ti.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] arm64: dts: ti: McASP fixes
Message-ID: <20240604133352.GA10282@francesco-nb>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>

Hello Jai,

On Tue, Jun 04, 2024 at 03:11:01PM +0530, Jai Luthra wrote:
> Drop McASP AFIFOs for all AM62 based platforms, as the extra buffering
> is not needed with BCDMA already having internal buffering.

Is this related with the issue in which after play/record or use the
McASP interface the system crashes or behaves in unexpected ways or this
is something else?

Francesco


