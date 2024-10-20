Return-Path: <linux-kernel+bounces-373433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AFA9A5699
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E8C1F218E3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1C7197A81;
	Sun, 20 Oct 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hsMrRxxT"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B22F43;
	Sun, 20 Oct 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729454769; cv=none; b=Ddni6SGD9q3PdI9puXZd7G10GqiKdRpyoblanMtMePasVL8OKvu9IqEKqK44El6A55H5oxu4I0kZSOUxb6dJbcdeD8cPC89D+kag5OyF7JIgYHSnaaEA2sPvQPIodbLtCNardvJ+BxkwKEg+XCQGI8aec5snXoHhfMivZHXHK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729454769; c=relaxed/simple;
	bh=Ahbx7CUucEUjI2jhOaXJ4pof18IYrdG8VErsPVILG6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwEt5HcTp+WyzrdE7QGbtVq6mggVC6SxFkFIR0R3MUYOsap+C8T8mbrkw9tkqL3QeBdDf5P9CoAYfJEdD7DykvmceWrLohTECtCAcvN4U+GNcW5Qiic3UJO9E1EB7rM8VqY+bH5gImKEKNLk/Nj1VxxPX0ctEzU1kDHXN7YMIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hsMrRxxT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729454758; x=1730059558; i=w_armin@gmx.de;
	bh=dZdhvZSb2QPid+/9nzPsnJLlsZsR7bNm4IVgeNqZ9KI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hsMrRxxTBCpZeQt5mvF3C2xGDK0yrtL5vufOMAtwia9K+zInzuy/iM00x9IJU9lq
	 /m34oKlZiNeXujv7zHNUCKRuTk9gFDSMsH//1EYnB9x+tbsgMLIA+2tFqHM5ljYU0
	 7VE7vSiC3VsfO9BL35q62N37AMj/6TyAY5eAxFX2wT66dHpvv/uj0ihivLbl8b9xu
	 pNCy6R3Vn/xngsc8gWU5os3f551N5MHzWafujtYFJll/4Ih8qvWDmNTZaunGzZOk+
	 EdXK5Gu1DEelHHOHyVv0nKsxkffBPrSBeP0mV4FTZ19f5OSywIWA+Uq3OzVvkMek9
	 HfUYGZKwzcMXSm6ujw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1tIFGX2zIR-00WeHj; Sun, 20
 Oct 2024 22:05:58 +0200
Message-ID: <8c54c79a-41f8-4aba-b037-aac181c7841b@gmx.de>
Date: Sun, 20 Oct 2024 22:05:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] alienware-wmi: alienware_wmax_command() is now
 input size agnostic
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081455.126851-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241017081455.126851-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FK3/ylvhOWyF4yJH3YyK+yas1/X0l/vvKJSgvYvLv9lQV+54RM
 kHchA/HS6lso/ezkd8/Q/jyCXOEZEFSIK1RpgAJFJ3NAl4mF9gjFH7H1AG2VyrrVhtTsLKR
 NzJ1NJmb64kGk/+QXnfAtxkgCuY6Gw5MXS+Ye26RpnTXpx7UPCWykLHPqd/UFaHxETDgwFn
 FHpAS7XATNCN2Au4RvCcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rqycklPgcTU=;1r1sZMg5YVN9Kg7zxVWxLIh5G9n
 a4AWPF0KB2CAEzHnczcv+5tVGHvm9mNY4LUdx9J8hgqW4WhvqSWe4l4/QtBIhTo5FIcL+A+qv
 yktgeEVlsaUyxYeJ/AjI7SS+M0If27zjatHmB7JDUcL7qCPBhGcCLC2B6cYVF0wHFQ4fRoxTE
 YPbKpCN+oMaG1WWPJii+o+Jnf7h868VBG7LmrdL8FXEf3XoQqATkSiC+TAxRUUGNk1CbalUzR
 seyE8qAo+LHk4LWXU54z3vI5VtqYkM02bvmk+J6/0c815fkNfzg6x9hmpC6RfVn1d2zdk984r
 UV5DMLmrLioF1A8iLjtrCo4nwMGexyrBASzZJh9flk7MCulyrLyzp6zO5XTqbjdsdhZPGS6VK
 +NUH2vSWM0bRu82AcQuB8gJX3idzHve6Q4FPo1TZZ0JB7ld3PFd1LnPPUY1E5zidspEV5zvW3
 UGj1t5wEBXpcn47qPo7hzLI6qetuGT2XjY5er3OL0UrLa2xOgXEhtuy6iUT9rKUQLRn30hrHO
 lKEsx4OiV+QN6lrXeV8EFUmvGrdUMPoKpNNMTP56Z2xHR/BY8RH/YqKMEo69VliL2QI/whEcA
 V+EqnIdO0bveSx6gc1QM+isO9gkQDq9mYSrmzvyyMar+EtrjoPQIGYOn/wKLXmQDnp/bhar01
 lX/bQo3jp4jaOHDtSYgmy3UvkLXDfzYFgtNGlMpKbHVokeULFWULkU1ocguaAWZZU+IkGE5os
 6f1spIqPFzCpEc67lMGuNv2kMspaMH7INp2/4xJR+xb32YmEgsRF6OUtLUkgS2OiBHebGNQWs
 i6AIGbppPa4HHtDIJltQ9TxQ==

Am 17.10.24 um 10:14 schrieb Kurt Borja:

> alienware_wmax_command() now takes void * and size_t instead of struct
> wmax_basic_args to extend support to new WMAX methods. Also int *out_dat=
a
> was changed to u32 *out_data, because new interface specifies u32 as out=
put
> parameter and all previous callers would pass u32 * regardless.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> ---
> v6:
>   - Unchanged
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
>   1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index 16a3fe9ac..b27f3b64c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_de=
vice *dev)
>   	kfree(zone_attrs);
>   }
>
> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_ar=
gs,
> -					  u32 command, int *out_data)
> +static acpi_status alienware_wmax_command(void *in_args, size_t in_size=
,
> +					  u32 command, u32 *out_data)
>   {
>   	acpi_status status;
>   	union acpi_object *obj;
>   	struct acpi_buffer input;
>   	struct acpi_buffer output;
>
> -	input.length =3D sizeof(*in_args);
> +	input.length =3D in_size;
>   	input.pointer =3D in_args;
>   	if (out_data) {
>   		output.length =3D ACPI_ALLOCATE_BUFFER;
> @@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_CABLE, &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_STATUS, &out_data);
>
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 1)
> @@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev=
,
>   		args.arg =3D 3;
>   	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
>
> -	status =3D alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL=
);
> +	status =3D alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_HDMI_SOURCE, NULL);
>
>   	if (ACPI_FAILURE(status))
>   		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> @@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *=
dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *=
dev,
>   	struct wmax_basic_args in_args =3D {
>   		.arg =3D 0,
>   	};
> -	status =3D alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STA=
TUS,
> -					&out_data);
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> @@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>   		args.arg =3D 2;
>   	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, bu=
f);
>
> -	status =3D alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTRO=
L,
> -					NULL);
> +	status =3D alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
>
>   	if (ACPI_FAILURE(status))
>   		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",

