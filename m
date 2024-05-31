Return-Path: <linux-kernel+bounces-196812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C378D620B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7516B2491F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC5158845;
	Fri, 31 May 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIbLskln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECE142E90;
	Fri, 31 May 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159313; cv=none; b=LMTWbHhtGNIe9tgh71V9on2Z7DwxGYdNV49popUrwhgB3ejAui/M7KpurmyEaAqku8FBQgblAEgxDc7zx/ESxM+UHoUW26LQ1GONQH/FEnrwwv1hZEHpBIphRHnM9hssHnR3J/ky+de2kj8llifz3qVB06cjl0fC044uaJxdoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159313; c=relaxed/simple;
	bh=fLDVnRp2IAtKkjqB1ZtUbEIJaqZKDsXV1q6SM1xR+VY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bXU4+VlpNy346uT03kMQnc1aWq2TTLfWMgm+MtpQk9KSG9p8aZc9GG2XnRBUwSLDLrdOkoREz8fUDxzOhSInNlCd0XXtl5GGyB4uUIJHmujaUSfikmBbvry/zc4QcnFzctezw1EslDmlQKWfrnJ6gqTRtWvGbhB0puAscVMJgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIbLskln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38218C116B1;
	Fri, 31 May 2024 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717159312;
	bh=fLDVnRp2IAtKkjqB1ZtUbEIJaqZKDsXV1q6SM1xR+VY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QIbLskln7cBxtaQm+S7TcJ1tq4kECx//N3wO8PdN2u4JxQIbloEappMANjQnfu292
	 OYYPBZjdYls+EUgs4OqVKJRuWTB3ieijOY0TBzVs3Nj6pwDXiCpDTYTIc8pA/+N9SF
	 pKy2PHoJmmIHattoDi8SardiF8D/FHhEyZyk9cptlotMIuk2oLN/4epRvFk2e7NVC2
	 Wfw9tet685AR+8HWFUk9tUcVigCWxaOa8SqQb1VTNMN7llqDhRY4TMbqXA03ex/BZt
	 vGEUDODK6v561vrRqzpUaPIMsgJs9jHxnMbiP0d+9UjAOAtcad0Cf9Jx2+ScPN/CCP
	 NmxtZ6yN9VeHA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, 
 Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
In-Reply-To: <20240512143824.1862290-1-a-bhatia1@ti.com>
References: <20240512143824.1862290-1-a-bhatia1@ti.com>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: syscon: Add
 ti,am625-dss-oldi-io-ctrl compatible
Message-Id: <171715930996.1070129.13768578039000408095.b4-ty@kernel.org>
Date: Fri, 31 May 2024 13:41:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sun, 12 May 2024 20:08:24 +0530, Aradhya Bhatia wrote:
> Add TI DSS OLDI-IO control registers compatible for AM625 DSS. This is a
> region of 10 32bit registers found in the TI AM625 CTRL_MMR0 register
> space[0]. They are used to control the characteristics of the OLDI
> DATA/CLK IO as needed by the OLDI TXes controller node.
> 
> [0]: https://www.ti.com/lit/pdf/spruiv7
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add ti,am625-dss-oldi-io-ctrl compatible
      commit: a49338cd99221f63804417838ea241290c921e39

--
Lee Jones [李琼斯]


