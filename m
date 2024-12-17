Return-Path: <linux-kernel+bounces-449480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD29F4F97
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C375C7A3B65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F221F76BF;
	Tue, 17 Dec 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8svMNpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91771F7570;
	Tue, 17 Dec 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449765; cv=none; b=pkhENgUsJZS6DrtCZIupXV9/H5zmn+oODijF56q9OaABl39RcCc6A+8CvTIiE7sgqCtSMmRUo1BDyoBRLMu0GOjafNFCV8g6c1JIJ6x6tDFE/jQDfsDA5ypVLL5g46kkZKHIDI/iCE/ri2GmadhV64tJUElP2Q4f5pBzuKQvmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449765; c=relaxed/simple;
	bh=CZJa1lf0XxGXavdC8JLTJxpT9TC1vGySZ2P2ZodGIG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM0GfHOsW0Hlp/NDyn33nK5wkSqn6pPVDKBIm1X8HURumRNu31dhE539mH6rGvSQFfvZO5HWONdkOCmcBE5yrvtwDaAVN/sZk2p8MldKBJmP7LZ7aHmwY8xJ3gLe9K0H5bpHVz9Ojs3WNuQDIn58EmkiO3PJJyZVKF7rlbihG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8svMNpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C876C4CEE0;
	Tue, 17 Dec 2024 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449765;
	bh=CZJa1lf0XxGXavdC8JLTJxpT9TC1vGySZ2P2ZodGIG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8svMNptMqCVHSzi7cqLN6d/H+54ZPSh5lQOOAcxBnVQEkznpCJdKrqrn0rBhhB8X
	 5eNfx4TotT/nDoO3wBDSslA14DK+ioEhkz3arEQIK3jZBuUUA295cAHT4jFT/8KzU1
	 bFdkiXEaB7rO/GzCp//AeYvvAI8oioJ6cFNft9iJZsDxA6vswj4tGdK9KrDhrHBEay
	 vwxXrkbg3ViKOu35HImvr/ec5UxJ8yJyUujmgOwBAyQu4KqvVsmOTTPAAtA09fAUNF
	 PszCcio6lrqNQYky0el/9odb6yEn8g+auKuFBnsXufaVE6ChjTtKGuZXH7D+F5oF3x
	 bttP+x+FyTqgg==
Date: Tue, 17 Dec 2024 09:36:03 -0600
From: Rob Herring <robh@kernel.org>
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mohsquicinc.com@qualcomm.com,
	kernel@quicinc.com
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Add support for master clock
 frequency
Message-ID: <20241217153603.GA1832220-robh@kernel.org>
References: <20241216110341.3707-1-quic_pkumpatl@quicinc.com>
 <20241216110341.3707-2-quic_pkumpatl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216110341.3707-2-quic_pkumpatl@quicinc.com>

On Mon, Dec 16, 2024 at 04:33:40PM +0530, Prasad Kumpatla wrote:
> Introduce a property specifies the frequency of the master clock
> provided to the codec slave. The slave has the capability to adjust
> the frequency according to user needs in the defined range.
> 
> Also fixed yamllint check errors.

'Also' is the red flag for something that should be a separate commit.

If you see errors with these, you are not using the right config which 
is in Documentation/devicetree/bindings/.yamllint.

