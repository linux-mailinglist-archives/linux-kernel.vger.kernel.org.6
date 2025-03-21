Return-Path: <linux-kernel+bounces-571163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE234A6B9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A35917A29C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA7223321;
	Fri, 21 Mar 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAwYu+TS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F5222574
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556552; cv=none; b=tKGj6G+aW7Gu2t5vkQDplaFS20ucS7mrNSjcRhK19VJ7U0bgd67619vys3waDqTRDTwXa1x17o11ZYuQQ2EGHUNWefbLKejkwQEaxoNlVZ4U8u9jlCHNCrVjiccqkCjxoChQJnsQVFVHXzrzMpzn6lEKkTxe7kk66L+osM5wh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556552; c=relaxed/simple;
	bh=w6pm/3uQVgeX3C6FUcXlYnf+D/aHvjy6URFkChKSUkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4KAYJai+xprXU7qJ1pOyhh7omaECtZ8hDHh8ASC+zlLpG4VxF8Mqe3W8EgnlzY90NRNpb8zHXsm71MLwv9TXclITvVJxvpoyHlZyzUIM4+ohatNJ76/nmkQdDocRomf5sQxI8TNMBIj7Qb31+ttSCNOZc6l9T0zjcJ4Zz5FG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAwYu+TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC75C4CEE3;
	Fri, 21 Mar 2025 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742556551;
	bh=w6pm/3uQVgeX3C6FUcXlYnf+D/aHvjy6URFkChKSUkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAwYu+TSSeSRrqGZtk0IqMyHwzDcX73m9A73iN1gdYjGNPDxuQo/wsVPIQtil6Z8/
	 xLtTHD3BTYcyPGaFVLXHhuEvMatC5RXz+uZgH6aQAt4daOOFAPOBoqpb9GLXX8NlUj
	 dO2d43eMA9Uunt9Km9JoBQ28XEifrQ1ziJUUA6PiQ59KGvIWcgQGXzRugCHUDo5445
	 JsFDywgi5rTUrQJmxXOKR51D9gBGe4dHMXy3e2j0NOWVbL6WWjLbYjItYzsRZ0aMY6
	 hkDfnDMWlpotg3qY7P62ewlT1nAqSWvw23U0odHjKNLjWdtyDXoHPOYZ8/D0cz1rJG
	 0O6a1TcXdhlsw==
Date: Fri, 21 Mar 2025 11:29:07 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	blake.vermeer@keysight.com
Subject: Re: [PATCH v5] mfd: cgbc: Add a hwmon cell
Message-ID: <20250321112907.GI1750245@google.com>
References: <20250317-congatec-board-controller-hwmon-v5-1-a83dfcb156a7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317-congatec-board-controller-hwmon-v5-1-a83dfcb156a7@bootlin.com>

On Mon, 17 Mar 2025, Thomas Richard wrote:

> The Board Controller has some internal sensors. Add a hwmon cell for the
> cgbc-hwmon driver which adds support for temperature, voltage, current and
> fan sensors.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Hi Lee,
> 
> As Guenter applied the hwmon patch, I resubmit the MFD part with the
> subject line and commit message fixed.

Sorry, just seen this.

I already applied it and fixed the commit message.

-- 
Lee Jones [李琼斯]

