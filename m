Return-Path: <linux-kernel+bounces-575591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FCBA7048A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC5A16678D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208C25A62C;
	Tue, 25 Mar 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVTE8KaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76918A6AD;
	Tue, 25 Mar 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915134; cv=none; b=TyymZwBbzABH6f4xLD31Xcx8GVLAV3Nfgo/d6tzUfMYF/vaIUUcPdyTzHvgc0y1xtE1Ma0mc3LxB2cKV5Uo2USpTlzwPZ+A9lC4nd0N8uTCDE8WN/aUTK1/4OA0TUGvwENXFw7RyRYeY9GEbo1ypzGp4xHHYv9o0AqkBrgM6lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915134; c=relaxed/simple;
	bh=tYkFuVNOqMc+WisSuseoSwC3bMrHo79j15VWlOW9ZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx+sH9gd4W0GDZ7TswVr1l7sFK5m4Dh0WCStFArvWsOmS6uUMfPOrGJEL4n+V1T+tiLpnPLib5+nRU9JHFi3KqQr72OQ7Y/DY1wwmwYQirQSh4tPSVodeOXDmagqa6nAt0RKyUy4ll+VfcKB04ml9O9OJxqLNqRujkfvKznhfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVTE8KaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95FDC4CEE4;
	Tue, 25 Mar 2025 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915133;
	bh=tYkFuVNOqMc+WisSuseoSwC3bMrHo79j15VWlOW9ZpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVTE8KaWPLJ1X9ne9sjek3EkHMaxC7yjZIM7c2KQchHRDBoDElAH0n9V2LAin/4mx
	 vQRBieRUZbWaDr4iocwexomaAu+Otjd6a5XPZKGEm6QRllRjhX3149YHvgJZ1ux4po
	 HOSaG+ZAk/kTmNAUiwA0YzlilVD8Irunw7rcIyU0oVkkxwNlajBIX7Bzk8n5LFP1bR
	 jnWCcXqE3OwqRQ+pUtdIZ29AeUI6DT9QtYXCgnUvIMuxjUJhj6q1L4RY1kR8eJ3LRu
	 hxVoslgf9QJ3PzKnqpDc7pgnKgT4VsG4g8/LaOJPOhSZO+dS/gp/zUBG3K4cLTyX4k
	 8kLAtAV5I85pA==
Date: Tue, 25 Mar 2025 10:05:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Ultratronik
Message-ID: <174291491488.2033850.8276285159291271594.robh@kernel.org>
References: <20250325110409.2323611-1-goran.radni@gmail.com>
 <20250325110409.2323611-2-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325110409.2323611-2-goran.radni@gmail.com>


On Tue, 25 Mar 2025 12:04:05 +0100, Goran Rađenović wrote:
> From: Goran Rađenović <gradenovic@ultratronik.de>
> 
> Ultratronik GmbH is a German electronics company:
> https://www.ultratronik-ems.de/
> 
> Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring (Arm) <robh@kernel.org>




