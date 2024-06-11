Return-Path: <linux-kernel+bounces-210577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A19045C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA71282C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53F152503;
	Tue, 11 Jun 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4XUo7dd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F780607;
	Tue, 11 Jun 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137775; cv=none; b=XFLI3ZOEtZuL0BLJM+qq9HzbbCpXpgjFk/E9aBR2vhvWmhcN6QCbl4qOQmpWsj53V+aq4FRaSJZglbcLxyrUOio9ao/9QsXEhP1yuRjLSwWFMUc6iBQ5ri5VKr4KczBYOiE+T6gZmO5dmEVwh3vjSJ8qxC/QqfQrdbXINh/gEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137775; c=relaxed/simple;
	bh=8BI1xx2e+o4FKuQzNAeMZSKMyiuD5XBATLHA+ojBjAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuVObsC2jV+I3crwh/oUk2aXHDD+sALLyTNQFK5AqQjG4WFiXvkbFj7GBbVJoGB/rNnd6AbtvlVRFYoBqVGtdWXssMnH12STz7hHcZT8LeLALMsWPudlOAITAIodzRpLbHfgQsXONeAkuHDviczDUBQ8P1db6Jmhgy0V9goC31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4XUo7dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6862CC2BD10;
	Tue, 11 Jun 2024 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718137774;
	bh=8BI1xx2e+o4FKuQzNAeMZSKMyiuD5XBATLHA+ojBjAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4XUo7ddVWPEhCwtdYYKRs6QFki1++vEmmmJIGqZXQD16BlhaBMZcVUlSWHJiJzrk
	 cLQdAztqBBEylRbh6bQXF6sq0QiZJAKxgpuXIhRYIHi+YIhmigC5EaFnVWEHTogixa
	 mqw2dE6r6M/PyBBneGrZI/MhYnxgdK7oJygu68/2MBdlZ5SVulNNnM+MWhod/uKMbr
	 aTSeYhKVjO+SCRI32kFgjKs+VxgE/EqP9CdIQCT3M9QPofhn6M7C8Ziq+Gc05D725R
	 JD1URJQ6H3AbS6PJvEMGdDLEfEAVVKc0iQXV7kdqFTFkBZtUAcUymE/lMxb1RlNeXJ
	 VxPHGjVNTEYAA==
Date: Tue, 11 Jun 2024 14:29:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8804: Convert to dtschema
Message-ID: <171813777009.3019521.993719611004916573.robh@kernel.org>
References: <20240611122258.47406-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611122258.47406-1-animeshagarwal28@gmail.com>


On Tue, 11 Jun 2024 17:52:51 +0530, Animesh Agarwal wrote:
> Convert the WM8804 audio codec bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8804.yaml | 58 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8804.txt      | 25 --------
>  2 files changed, 58 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8804.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8804.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


