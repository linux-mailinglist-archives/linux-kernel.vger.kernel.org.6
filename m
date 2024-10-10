Return-Path: <linux-kernel+bounces-359150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82768998814
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B7B20E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AC1C9DE6;
	Thu, 10 Oct 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouiLWSVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605181C8FDB;
	Thu, 10 Oct 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567827; cv=none; b=sj3KZeQ6QRS//BpDBa2caH+ncpVFv+cUfYM80+C5BhxFpFBa5xUHylRD1M7IjNs3eZ3tKEv4MOOnQ9DXWS55ibM4jDBTozWHGrs3+GCuIc7gOEM4WBXlEPLIpSCebRkmVAuaU12TRVkk0ECV4FHtQjUxCt2v+0i/UPPAW6OO00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567827; c=relaxed/simple;
	bh=T9lcuZlL1IcqpWqmvcegkFiFS3QjoOhVBciZ3l8fVBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BKsi4grjGH1nKuQCmh9rLXwuckRRulx00PqY5fiDGagHd+JmP7kPlWk1Pbsgd/VAcuNQuERhrur965Q2izr+ZUL48HRFUCojlwEtGOcSgFY96MWxpzfz9mXwluY0TerbUH27iRsSjn4RDKiLG7NsWhwxzK9zMD18u4sPBRpG9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouiLWSVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F9C4CEC5;
	Thu, 10 Oct 2024 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728567825;
	bh=T9lcuZlL1IcqpWqmvcegkFiFS3QjoOhVBciZ3l8fVBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ouiLWSVUxqY5F6ZvN8UHcJcrT8UTGUvjSD9NXVUvROglGTTi0XglcHU+HlRQtAcUt
	 8JxKGS0cO4YZ/CXHKaTEmxJuhupAqP5K4CEue1ub9QtlT2ePVoBIZBdmgdc7Wp3xlb
	 7gvXcbwkH+G+7ldc+OofMf11y4By8Pa29iFF0IlUEDE7vBwF4dq+8X68EOb00GVmoG
	 mO4tTUCXK5lCtTRwNX5EG9l/OSDKQ1fostQ8KpVKwcqDmDLQPCum1fDtqQ9tyl2smK
	 5O2QKXILr3UFaeFpsoYceT0gHJV/9YwM/eZLxmrqMWwRNTxvCcGuMVwgTylU1UWo1Q
	 YO3TC0PWROOgQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240930112121.95324-18-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-18-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 17/35] mfd: atmel-smc: Reorganize kerneldoc
 parameter names
Message-Id: <172856782414.2579482.191569046766660261.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 14:43:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 30 Sep 2024 13:21:03 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> 

Applied, thanks!

[17/35] mfd: atmel-smc: Reorganize kerneldoc parameter names
        commit: dfa6ab41d9d939135e96c4496d044ca4052cc813

--
Lee Jones [李琼斯]


